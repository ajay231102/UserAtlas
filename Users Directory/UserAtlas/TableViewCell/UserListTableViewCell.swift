//
//  UserListTableViewCell.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    static let identifier = "UserListTableViewCell"
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var userImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with user: UserDetail) {
        userImageView.layer.borderColor = UIColor(hex: "DDDDDD").cgColor
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.cornerRadius = 4.0
        lblUserName.text = user.name.fullName
        lblUserName.font = UIFont(name: Constants.FontNames.ProximaBold, size: 16.0)
        lblUserEmail.text = user.email
        lblUserEmail.font = UIFont(name: Constants.FontNames.ProximaRegular, size: 12.0)
        userImage.loadImageFromUrl(user.picture.medium, thumbnailUrl: user.picture.thumbnail)
        
    }
}
