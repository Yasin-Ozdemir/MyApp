//
//  ViewController.swift
//  MyApp
//
//  Created by Yasin Özdemir on 10.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func createButton(_ sender: Any) {
        performSegue(withIdentifier: "toCreateVC", sender: nil)
    }
    
    @IBAction func signinButton(_ sender: Any) {
        if EmailText.text != "" && passwordText.text != ""{
            
            Auth.auth().signIn(withEmail: EmailText.text!, password: passwordText.text!) { authData, err in
                if err != nil{
                    self.makeAlert(title: "ERROR", message: err?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(title: "ERROR", message: "E-mail or Password ?")
        }
    }
    
    func makeAlert(title : String , message : String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var OkButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(OkButton)
        self.present(alert, animated: true)
    }
}

