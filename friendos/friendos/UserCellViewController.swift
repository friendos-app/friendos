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

    @IBOutlet weak var userUsername: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    
    var user: [String:Any]!
    var userName: [String:Any]!
    var user2: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userBio.text = user["bio"] as? String
        userUsername.text = userName["username"] as? String
        
        print(user)
        
        if let imageFile = user2?["image"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            userImage.af.setImage(withURL: url)
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
