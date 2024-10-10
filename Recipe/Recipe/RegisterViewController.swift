//
//  RegisterViewController.swift
//  Recipe
//
//  Created by friend on 01/07/24.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    
    @IBOutlet weak var newUserlagao: UIImageView!
    
    @IBOutlet weak var newUsername: UILabel!
    
    @IBOutlet weak var newUserNameTextField: UITextField!
    
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var dobTextFieldField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var createPasswordLabel: UILabel!
    
    @IBOutlet weak var createPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        guard let username = newUserNameTextField.text else { return}
        guard let  dob = dobTextFieldField.text else { return}
        guard let email =  emailTextField.text else { return }
        guard  let password = createPasswordTextField.text else { return }
        
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult , error in
            if let e = error
            {
                print("error: \(error)")
            }
            else{
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
    }

