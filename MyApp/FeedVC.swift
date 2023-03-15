//
//  FeedVC.swift
//  MyApp
//
//  Created by Yasin Özdemir on 10.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class FeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var userNamesArray = [String]()
    var userImagesArray = [String]()
    var titleArray = [String]()
    var likeArray = [String]()
    var topicArray = [String]()
    var documentIdArray = [String]()
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        getData()
        
    }
    
    
    func getData(){
        var fireStore = Firestore.firestore()
        /*fireStore.collection("User Names").addSnapshotListener { snapShot, err in
            if err != nil{
                self.makeAlert(title: "ERROR", message: err?.localizedDescription ?? "error")
            }else{
                if snapShot?.isEmpty != true{
                    for documents in snapShot!.documents{
                        if let userName = documents.get("user name") as? String{
                            self.userNamesArray.append(userName)
                        }
                        if let imageUrl = documents.get("imageUrl") as? String{
                            self.userImagesArray.append(imageUrl)
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
        }*/
        
        fireStore.collection("Topics").order(by: "likes", descending: true).addSnapshotListener { snapShot2, err2 in
            if err2 != nil{
                self.makeAlert(title: "ERROR", message: err2?.localizedDescription ?? "error")
            }else{
                if snapShot2?.isEmpty != true{
                    self.userNamesArray.removeAll()
                    self.userImagesArray.removeAll()
                    self.likeArray.removeAll()
                    self.topicArray.removeAll()
                    self.titleArray.removeAll()
                    self.documentIdArray.removeAll()
                    
                    
                    
                    
                    for documents2 in snapShot2!.documents {
                        if let documentId = documents2.documentID as? String{
                            self.documentIdArray.append(documentId)
                          
                        }
                        if let title = documents2.get("title") as? String{
                            self.titleArray.append(title)
                        }
                        if let topic = documents2.get("topic") as? String{
                            self.topicArray.append(topic)
                        }
                        if let like = documents2.get("likes") as? Int{
                            self.likeArray.append(String(like))
                        }
                        if let imageUrl = documents2.get("imageurl") as? String{
                            self.userImagesArray.append(imageUrl)
                        }
                        if let username = documents2.get("username") as? String{
                            self.userNamesArray.append(username)
                        }
                    }
                }
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! CELL
        
        cell.titleLabel.text = self.titleArray[indexPath.row]
        cell.userNameLabel.text = self.userNamesArray[indexPath.row]
        cell.userImage.sd_setImage(with: URL(string: self.userImagesArray[indexPath.row] ))
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            var detail = segue.destination as? DetailsVC
            DispatchQueue.main.async {
                detail!.titleLabel.text = self.titleArray[self.index]
                detail!.textView.text = self.topicArray[self.index]
                detail!.likeLabel.text = self.likeArray[self.index]
                detail?.documentID = self.documentIdArray[self.index]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func makeAlert(title : String , message : String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var OkButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(OkButton)
        self.present(alert, animated: true)
    }

}
