//
//  UserContactDetailsTableViewCell.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 22/05/26.
//

import UIKit

class UserContactDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "UserContactDetailsTableViewCell"
    
    class Model {
        var detail: String
        var type: ContactDetailCellType
        
        init(detail: String, type: ContactDetailCellType) {
            self.detail = detail
            self.type = type
        }
        
    }

    @IBOutlet weak var lblContactType: UILabel!
    @IBOutlet weak var lblContactDetail: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(cellModel: UserContactDetailsTableViewCell.Model) {
        lblContactType.text = cellModel.type.getTitleName()
        lblContactDetail.text = cellModel.detail
        containerView.layer.cornerRadius = 4.0
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor(hex: "DDDDDD").cgColor
    }
    
}
