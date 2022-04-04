//
//  userProfileCell.swift
//  friendos
//
//  Created by Daniel Ruiz on 4/3/22.
//

import UIKit

class profileCell: UITableViewCell {
    
    
    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var interestView: UIView!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userBio: UILabel!
    
    
    @IBOutlet weak var bioView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
