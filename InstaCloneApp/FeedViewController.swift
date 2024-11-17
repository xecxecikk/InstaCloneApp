//
//  FeedViewController.swift
//  InstaCloneApp
//
//  Created by XECE on 17.11.2024.
//

import UIKit

import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, FeedCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
            
        }
        func getDataFromFirestore() {
            let fireStoreDatabase = Firestore.firestore()
            // .order kullanımı feed görünümünde tarih sırasına göre dizmesini sağlar 
            fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print ( error?.localizedDescription )
                } else {
                    
             
                    if snapshot?.isEmpty != true && snapshot != nil {
                        
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                      
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postComment = document.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String  {
                            self.userImageArray.append(imageUrl)
                        }
                    }
                        DispatchQueue.main.async {
                    self.tableView.reloadData()
                        }
                    }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        
        // Resim yükleme sırasında hata kontrolü
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]), placeholderImage: UIImage(named: "placeholder.png")) { image, error, cacheType, url in
            if let error = error {
                print("Image loading error: \(error.localizedDescription)")
            }
        }
        
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        cell.delegate = self
        return cell
    }

    
    func didRequestDelete(cell: FeedCell) {
           guard let indexPath = tableView.indexPath(for: cell) else { return }
           
           // Kullanıcıdan onay alın
           let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this post?", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Cancellation", style: .cancel, handler: nil))
           alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
               self.deletePost(at: indexPath)
           }))
           present(alert, animated: true, completion: nil)
    }
        
        private func deletePost(at indexPath: IndexPath) {
            let documentIdToDelete = documentIdArray[indexPath.row]
            let fireStoreDatabase = Firestore.firestore()
            
            fireStoreDatabase.collection("Posts").document(documentIdToDelete).delete { error in
                if let error = error {
                    print("Error deleting post: \(error.localizedDescription)")
                } else {
                    print("Post deleted successfully.")
                    
                    // Tablo verilerini güncelle
                    self.documentIdArray.remove(at: indexPath.row)
                    self.userEmailArray.remove(at: indexPath.row)
                    self.userCommentArray.remove(at: indexPath.row)
                    self.likeArray.remove(at: indexPath.row)
                    self.userImageArray.remove(at: indexPath.row)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    
    
    
    
    
    
}
