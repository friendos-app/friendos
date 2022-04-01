//
//  UserCell.swift
//  friendos
//
//  Created by Daniel Ruiz on 3/22/22.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserUsername: UILabel!
    @IBOutlet weak var UserBio: UILabel!
    
    @IBOutlet weak var friendIcon: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
