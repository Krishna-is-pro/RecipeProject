//
//  LoginViewController.swift
//  Recipe
//
//  Created by friend on 01/07/24.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginLogo: UIImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
                guard let username = userNameTextField.text else { return}
                guard  let password = passwordTextField.text else { return }
        
                Auth.auth().signIn(withEmail: username, password: password) { firebaseResult , error in
                    if let e = error
                    {
                        print("error : \(error)")
                    }
                    else{
                        self.performSegue(withIdentifier: "goToNext", sender: self)
                    }
                }
            }
    }
    
    
  

