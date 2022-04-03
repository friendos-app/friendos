//
//  SettingsViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/23/22.
//

import UIKit
import Parse

class SettingsViewController: UIViewController  {

    var cancellable: Any?
    let curUser = PFUser.current()
    
    @IBAction func onLogoutTouch(_ sender: Any) {
        PFUser.logOutInBackground()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    // Copy referal link to clipboard
    @IBAction func onCopyTouch(_ sender: Any) {
        let refLink = curUser?["referal_link"] as? String
        UIPasteboard.general.string = "https:\\" + refLink!
        
        // Tell user we copied to clipboard
        let copiedAlert = UIAlertController(title: "Copied to Clipboard", message: "Referal URL copied", preferredStyle: .alert)
        
        // Add action to dismiss
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        copiedAlert.addAction(okayAction)
        
        present(copiedAlert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the referall link to the correct value

    }
}

// Save the color to the DB
//curUser?["background_color"] = "\(red)-\(green)-\(blue)-\(alpha)"
//curUser?.saveInBackground()
