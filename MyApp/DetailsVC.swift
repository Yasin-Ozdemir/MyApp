//
//  DetailsVC.swift
//  MyApp
//
//  Created by Yasin Özdemir on 10.03.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DetailsVC: UIViewController {

    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var documentID = ""
    var totalLike = 0
    var userdocumentID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    
    

    @IBAction func likeButton(_ sender: Any) {
        var firestore = Firestore.firestore()
        
        var like = Int(likeLabel.text!)! + 1
        
        likeLabel.text = String(like)
        
        var likeData = ["likes" : like]
        
        firestore.collection("Topics").document(documentID).setData(likeData, merge: true)

    }
    

}
