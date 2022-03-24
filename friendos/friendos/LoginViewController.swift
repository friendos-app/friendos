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
        let user = PFUser()
        user.username = userNameText.text
        user.password = passwordText.text
        // Set up users referral link
        user["referal_link"] = "https://getfriendos.com/" + self.userNameText.text!
        
        // Attempt to sign the user up
        user.signUpInBackground { success, error in
            if let error = error {
                let errorString = error.localizedDescription
                print(errorString)
            } else {
                
                
                
                
                
                self.performSegue(withIdentifier: "goLoginProfile", sender: nil)
            }
        }

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
    
    // Override prepare for segue to direct towards profile on login if this is a new sign up
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goLoginProfile") {
            // Get the tab bar
            let barViewController = segue.destination as! UITabBarController
            // Get the third nav controller (Profile)
            let destViewController = barViewController.viewControllers![2] as! UINavigationController
            // Set the selected controller to the one we are going to on sign up
            barViewController.selectedViewController = destViewController
            
        }
    }
}
