//
//  FeedCell.swift
//  InstaCloneApp
//
//  Created by XECE on 25.11.2024.
//


import UIKit
import Firebase
import FirebaseFirestore
protocol FeedCellDelegate: AnyObject {
    func didRequestDelete(cell: FeedCell)
}

class FeedCell: UITableViewCell {
    
   
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var documentIdLabel: UILabel!
    
    weak var delegate: FeedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!) {
            let likeStore = ["likes" : likeCount + 1 ] as [String : Any]
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true) //sadece likestore güncellemek için
            
        }
        }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.didRequestDelete(cell: self)
        
        
        
        
    }
    
    
    
} 
