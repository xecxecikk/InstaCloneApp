//
//  UpdateViewController.swift
//  InstaCloneApp
//
//  Created by XECE on 17.11.2024.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // resim tıklanabilir
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage (){
        // kullanıcının fotoğraf kütüphanesine ulaşmak için
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    //kullanıcı fotoğraf seçince ne olacağını;
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleInput: String , messageInput: String) {
        let alert = UIAlertController(title: "OK", message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
            let storageReference = storage.reference()
            let mediaFolder = storageReference.child("media")
            
            if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
                let uuid = UUID().uuidString
                let imageReference = mediaFolder.child("\(uuid).jpg")
                imageReference.putData(data, metadata: nil) { (metadata, error) in
                    if error != nil {
                        self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                    } else {
                        imageReference.downloadURL { (url, error) in
                            if let url = url {
                                let imageurl = url.absoluteString
                                let fireStoreDatabase = Firestore.firestore()
                                let postDictionary = [
                                    "imageUrl": imageurl,
                                    "postedBy": Auth.auth().currentUser!.email!,
                                    "postComment": self.commentText.text!,
                                    "date": FieldValue.serverTimestamp(),
                                    "likes": 0
                                ] as [String: Any]
                                
                                fireStoreDatabase.collection("Posts").addDocument(data: postDictionary) { error in
                                    if error != nil {
                                        print("Error saving post: \(error!.localizedDescription)")
                                    } else {
                                        // Tab Bar'da Feed ekranına geç
                                        DispatchQueue.main.async {
                                            self.tabBarController?.selectedIndex = 0
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    }
