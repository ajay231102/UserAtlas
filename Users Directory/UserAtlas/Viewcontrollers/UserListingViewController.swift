//
//  UserListingViewController.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import UIKit

class UserListingViewController: UIViewController {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var settingIconContainerView: UIView!
    @IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setupUI() {
        self.lblHeader.font = UIFont(name: Constants.FontNames.CabinetBold, size: 18)
        self.lblDescription.font = UIFont(name: Constants.FontNames.ProximaSemiBold, size: 12)
        self.settingIconContainerView.layer.cornerRadius = self.settingIconContainerView.bounds.height / 2
        self.searchBarContainerView.layer.cornerRadius = self.searchBarContainerView.bounds.height / 2
    }
    
    @IBAction func settingsBtnTapped(_ sender: Any) {
    }
    

}
