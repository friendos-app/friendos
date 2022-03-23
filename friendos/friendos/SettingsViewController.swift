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
    
    @IBAction func onColorTap(_ sender: UITapGestureRecognizer) {
        
        // Initialize the color picker
        let picker = UIColorPickerViewController()
        // Set up the initial color
        picker.selectedColor = self.view.backgroundColor!
        // Set up the delegate
        picker.delegate = self
        // Present the picker
        self.present(picker, animated: true, completion: nil)
        
//        // Initialize the color picker
//        let picker = UIColorPickerViewController()
//
//        picker.selectedColor = self.view.backgroundColor!
//
//        // Variables to hold colors for storing in db
        
//
//        self.cancellable = picker.publisher(for: \.selectedColor).sink {
//            color in
//            DispatchQueue.main.async {
//
//
//
//                let colorWorked = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//                print(colorWorked)
//                print(red)
//                print(green)
//                print(blue)
//                print(alpha)
//                    // self.view.backgroundColor = color
//
//            }
//        }
//
//        self.present(picker, animated: true, completion: nil)
//
//        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
//            print("Finished")
//        }

        
    }
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
