//
//  SettingsViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/23/22.
//

import UIKit
import Parse

class SettingsViewController: UIViewController, UIColorPickerViewControllerDelegate  {

    var cancellable: Any?
    let curUser = PFUser.current()
    
    @IBAction func onLogoutTouch(_ sender: Any) {
        PFUser.logOutInBackground()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onColorTouch(_ sender: Any) {
        // Initialize the color picker
        let picker = UIColorPickerViewController()
        // Set up the initial color
        picker.selectedColor = self.view.backgroundColor!
        // Set up the delegate
        picker.delegate = self
        // Present the picker
        self.present(picker, animated: true, completion: nil)
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
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        // Colors to hold background color
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Get the selected color
        let color = viewController.selectedColor
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Save the color to the DB
        curUser?["background_color"] = "\(red)-\(green)-\(blue)-\(alpha)"
        curUser?.saveInBackground()
        
        // Set background color
//        self.view.backgroundColor = color
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        print("Color changed")
    }
    
    



}
