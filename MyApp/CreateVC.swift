//
//  CreateVC.swift
//  MyApp
//
//  Created by Yasin Özdemir on 10.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore


class CreateVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UITextField! // TEXT
    
    @IBOutlet weak var passwordLabel: UITextField! // TEXT
    
    @IBOutlet weak var usernameLabel: UITextField! // TEXT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func selectImage(){
        var picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as! UIImage
        
        self.dismiss(animated: true)
    }
    

    
    @IBAction func signupButton(_ sender: Any) {
        if emailLabel.text != "" && passwordLabel.text != ""{
            Auth.auth().createUser(withEmail: emailLabel.text!, password: passwordLabel.text!) { authData, err in
                if err != nil{
                    self.makeAlert(title: "ERROR", message: err?.localizedDescription ?? "error")
                }else{
                    
                    // storage
                    var storage = Storage.storage()
                    var storageReference = storage.reference()
                    var mediaFolder = storageReference.child("Media")
                    
                    var id = UUID()
                    var imageFolder = mediaFolder.child("\(id).jpg")
                    var imageData = self.imageView.image?.jpegData(compressionQuality: 0.5) as! Data
                    
                    imageFolder.putData(imageData) { mymetadata, err2 in
                        if err2 != nil{
                            self.makeAlert(title: "ERROR", message: err2?.localizedDescription ?? "error")
                        }else{
                            imageFolder.downloadURL { myurl, error in
                                if error != nil{
                                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                                }else{
                                    var imageUrl = myurl?.absoluteString
                                    // veri tabanı
                                    var fireStore = Firestore.firestore()
                                    fireStore.collection("User Names")
                                    
                                    var data = ["user name" : self.usernameLabel.text! , "imageUrl" : imageUrl , "e-mail" : self.emailLabel.text! , "total title" : 0] as! [String : Any]
                                    
                                    fireStore.collection("Users").addDocument(data: data) { errr in
                                        if errr != nil{
                                            self.makeAlert(title: "ERROR", message: errr?.localizedDescription ?? "error")
                                            
                                        }else{
                                            
                                            self.performSegue(withIdentifier: "toVC", sender: nil)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            
        }else{
            makeAlert(title: "ERROR", message: "E-mail or Password ?")
        }
    }
    func makeAlert(title : String , message : String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var OkButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(OkButton)
        self.present(alert, animated: true)
    }
    
}
