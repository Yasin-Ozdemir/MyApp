//
//  SettingVC.swift
//  MyApp
//
//  Created by Yasin Özdemir on 10.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class SettingVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
  
    
    
    @IBOutlet weak var topicLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fireStore = Firestore.firestore()
        fireStore.collection("Users").addSnapshotListener { qss, err in
            if err == nil{
                if qss?.isEmpty != true{
                    for documents in qss!.documents{
                        if Auth.auth().currentUser?.email == (documents.get("e-mail") as! String){
                            
                           
                            if let username = documents.get("user name") as? String{
                                self.userNameLabel.text = username
                            }
                                
                                if let totaltitle = documents.get("total title") as? Int{
                                    self.topicLabel.text = ("Total Topic = \(String(totaltitle))")
                                }
                                if let url = documents.get("imageUrl") as? String{
                                    self.imageView.sd_setImage(with: URL(string: url))
                                }
                           
                            
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    @IBAction func logoutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{print("error")}
        
        
    }
}
