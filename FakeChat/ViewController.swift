//
//  ViewController.swift
//  FakeChat
//
//  Created by Bilguun Batbold on 23/3/19.
//  Copyright © 2019 Bilguun. All rights reserved.
//

import UIKit
import NotificationCenter
import Firebase
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signUpOrLoginDidTap(_ sender: UIButton) {
        
        // try and get the required fields
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            //show alert if not filled
            let alert = UIAlertController(title: "Error", message: "Please ensure required fields are filled", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //button tags have been set in the storyboard  0 -> register 1 -> Login
        switch sender.tag {
        case 0:
            registerUser(email: email, password: password)
        case 1:
            loginUser(email: email, password: password)
        default:
            return
        }
    }
    
    private func registerUser(email: String, password: String) {
        SVProgressHUD.show(withStatus: "Registering..")
        //create user and wait for callback
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            else {
                // if not error, navigate to next page
                self.performSegue(withIdentifier: "showChat", sender: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    private func loginUser(email: String, password: String) {
        SVProgressHUD.show(withStatus: "Logging in..")
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            else {
                self.performSegue(withIdentifier: "showChat", sender: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        do {
            try Auth.auth().signOut()
            print("user signed out")
        }
        catch {
            print("Error signing out")
        }
        
        emailTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
    }
}
