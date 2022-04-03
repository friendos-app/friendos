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
    
    @IBOutlet weak var friendosBlueButton: UIButton!
    @IBOutlet weak var friendosPinkButton: UIButton!
    
    
    
    
    
    @IBAction func onLogoutTouch(_ sender: Any) {
        PFUser.logOutInBackground()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onFreindosBlueTouch(_ sender: Any) {
        view.backgroundColor = UIColor(named: "FriendosBlue")
        UserDefaults.standard.set("FriendosBlue", forKey: "background_color")
        // Save the color to the DB
        curUser?["background_color"] = "FriendosBlue"
        curUser?.saveInBackground()

    }
    
    @IBAction func onFriendosPinkTouch(_ sender: Any) {
        view.backgroundColor = UIColor(named: "FriendosPink")
        UserDefaults.standard.set("FriendosPink", forKey: "background_color")
        // Save the color to the DB
        curUser?["background_color"] = "FriendosPink"
        curUser?.saveInBackground()
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
        
        // Set background color
        view.backgroundColor = UIColor(named: UserDefaults.standard.string(forKey: "background_color")!)

        friendosBlueButton.layer.borderWidth = 3
        friendosBlueButton.layer.cornerRadius = 10
        friendosPinkButton.layer.borderWidth = 3
        friendosPinkButton.layer.cornerRadius = 10
    }
}

