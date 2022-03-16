//
//  LoginViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/16/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    // Variables that hold username and password
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    // Runs upon view loading
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Sign up a new user and segue to the profile screen
    @IBAction func onSignUp(_ sender: Any) {
    }
    
    // Login a user and segue to the Home screen
    @IBAction func onLogin(_ sender: Any) {
        // Login with the specified username and password
        PFUser.logInWithUsername(inBackground: self.userNameText.text!, password: self.passwordText.text!) {
          (user: PFUser?, error: Error?) -> Void in
          // If we have a user, we can login and perform the segue to home
          if user != nil {
            print("login success")
              self.performSegue(withIdentifier: "goLoginHome", sender: nil)
          } else {
            print(error!.localizedDescription)
          }
        }
    }
}
