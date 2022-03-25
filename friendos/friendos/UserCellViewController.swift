//
//  UserCellViewController.swift
//  friendos
//
//  Created by Daniel Bracamontes on 3/25/22.
//

import UIKit
import Parse

class UserCellViewController: UIViewController {

    var user: [String:Any]!
//
    override func viewDidLoad() {
        super.viewDidLoad()

        print("This is the new view")
        
        print(user)
        
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
