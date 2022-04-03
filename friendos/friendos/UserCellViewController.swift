//
//  UserCellViewController.swift
//  friendos
//
//  Created by Daniel Bracamontes on 3/25/22.
//

import UIKit
import Parse
import AlamofireImage

class UserCellViewController: UIViewController {
    
    @IBOutlet weak var onSubmitButton: UIButton!
    
    @IBOutlet weak var bioView: UIView!
    var friends = false
    
    @IBAction func onSubmitRequest(_ sender: Any) {
        
        //let cur_user = PFUser.current()
        
        print(user2["username"])
        
        var parseObject = PFObject(className:"Connections")

        parseObject["requestor"] = PFUser.current()
        parseObject["target_user"] = user2
        // parseObject["accepted"] = true

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
              // The object has been saved.
              self.onSubmitButton.isHidden = true
            
          } else {
            // There was a problem, check error.description
          }
        }
    }
    

    @IBOutlet weak var userUsername: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    
    var user: [String:Any]!
    var userName: [String:Any]!
    var user2: PFObject!
    @IBOutlet weak var interestsView: UIView!
    @IBOutlet weak var interestsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.layer.borderWidth = 6
        bioView.layer.borderWidth = 6
        bioView.layer.borderColor = UIColor.black.cgColor
        bioView.layer.cornerRadius = 8
        interestsView.layer.borderWidth = 6
        interestsView.layer.borderColor = UIColor.black.cgColor
        interestsView.layer.cornerRadius = 8
        
        userBio.text = user["bio"] as? String
        userUsername.text = userName["username"] as? String
        
        self.onSubmitButton.isHidden = self.friends
        
        if let imageFile = user2?["image"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            userImage.af.setImage(withURL: url)
        }
        
        let query = PFQuery(className: "Connections")
        query.whereKey("requestor", equalTo: PFUser.current())
        query.whereKey("target_user", equalTo: user2)
        query.whereKeyDoesNotExist("accepted")

        let query2 = PFQuery(className: "Connections")
        query2.whereKey("target_user", equalTo: PFUser.current())
        query2.whereKey("requestor", equalTo: user2)
        query.whereKeyDoesNotExist("accepted")

        // Query the DB to find friends
        query.findObjectsInBackground { query1_res, error1 in
            if (error1 == nil) {
                query2.findObjectsInBackground { query2_res, error2 in
                    if (error2 == nil) {
                        var connections = [PFObject]()
                        connections.append(contentsOf: query1_res!)
                        connections.append(contentsOf: query2_res!)
                        
                        if connections.count > 0 {
                            self.onSubmitButton.isHidden = true
                        }
                        
                        
                        
                    } else {
                        print("\(error2)")
                    }
                }
                
                
                
            } else {
                print("\(query1_res)")
                print("\(error1)")
            }
        }
    
        
        
        // Do any additional setup after loading the view.
//        print(user[""])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
