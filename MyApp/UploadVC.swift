//
//  UploadVC.swift
//  MyApp
//
//  Created by Yasin Özdemir on 10.03.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class UploadVC: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    
    
    @IBOutlet weak var textView: UITextView!
    
    var imageurl = ""
    var userName = ""
    var documentID = ""
    var totalTitle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var firebase = Firestore.firestore()
        firebase.collection("Users").addSnapshotListener { snapShot, err in
            if err != nil{
                self.makeAlert(title: "ERROR", message: err?.localizedDescription ?? "error")
            }else{
                if snapShot?.isEmpty != true{
                    for documents in snapShot!.documents{
                        if Auth.auth().currentUser?.email == (documents.get("e-mail") as! String){
                           
                            if let imageuRl = documents.get("imageUrl") as? String{
                                self.imageurl = imageuRl
                            }
                            if let username = documents.get("user name") as? String{
                                self.userName = username
                            }
                            if let id = documents.documentID as? String{
                                self.documentID = id
                            }
                            if let totaltitle = documents.get("total title") as? Int{
                                self.totalTitle = totaltitle
                            }
                                
                          
                            
                        }
                        
                    }
                }
            }
        }
        
        
    }
    

    @IBAction func shareButton(_ sender: Any) {
        var fireBase = Firestore.firestore()
        
        var topics = ["title" : titleText.text! , "topic" : textView.text! , "likes" : 0 ,"imageurl" : imageurl , "username" : userName] as! [String : Any]
        
        fireBase.collection("Topics").addDocument(data: topics) { err in
            if err != nil{
                self.makeAlert(title: "ERROR", message: err?.localizedDescription ?? "error")
            }else{
                self.titleText.text = ""
                self.textView.text = "Start to write ..."
                var total = (self.totalTitle) + 1
                var titleData = ["total title" : total]
                fireBase.collection("Users").document(self.documentID).setData(titleData, merge: true)
                
                self.tabBarController?.selectedIndex = 0
            }
        }
        
    }
    
    func makeAlert(title : String , message : String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var OkButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(OkButton)
        self.present(alert, animated: true)
    }
    
    

}
