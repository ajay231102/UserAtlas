//
//  UserContactDetailsHeaderTableViewCell.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 23/05/26.
//

import UIKit

class UserContactDetailsHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "UserContactDetailsHeaderTableViewCell"
    
    class Model {
        var picture: UserPicture?
        var name: String?
        
        init(picture: UserPicture? = nil, name: String? = nil) {
            self.picture = picture
            self.name = name
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user: UserContactDetailsHeaderTableViewCell.Model) {
        lblName.text = user.name
        profileImage.loadImageFromUrl(user.picture?.large ?? "", thumbnailUrl: user.picture?.thumbnail)
        
        setupUI()
    }
    
    private func setupUI() {
        
        containerView.layer.cornerRadius = 4.0
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor(hex: "DDDDDD").cgColor
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.masksToBounds = true
//        profileImageView.layer.shadowColor = UIColor(hex: "9A9A9A").cgColor
//        profileImageView.layer.shadowOffset = .init(width: 0, height: 1)
//        profileImageView.layer.shadowRadius = 1.0
//        profileImageView.layer.shadowOpacity = 0.5
    }
}
