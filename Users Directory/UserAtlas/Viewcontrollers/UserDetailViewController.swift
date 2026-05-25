//
//  UserDetailViewController.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UserDetailsViewModel!
    
    public static func getInstance(model: UserDetailsViewModel) -> UserDetailViewController {
        let vc: UserDetailViewController = UserDetailViewController.loadFromNib()
        vc.viewModel = model
        return vc
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        bindViewModel()
    }

    private func setupUI() {
        self.lblHeader.font = UIFont(name: Constants.FontNames.CabinetBold, size: 18)
        self.lblDescription.font = UIFont(name: Constants.FontNames.ProximaSemiBold, size: 12)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "UserContactDetailsHeaderTableViewCell", bundle: nil),
            forCellReuseIdentifier: UserContactDetailsHeaderTableViewCell.identifier
        )
        
        tableView.register(
            UINib(nibName: "UserContactDetailsTableViewCell", bundle: nil),
            forCellReuseIdentifier: UserContactDetailsTableViewCell.identifier
        )
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func bindViewModel() {
        viewModel.onDataReload = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserContactDetailsHeaderTableViewCell.identifier,
                for: indexPath
            ) as? UserContactDetailsHeaderTableViewCell else {
                return UITableViewCell()
            }
            let model = viewModel.getHeaderCellModel()
            cell.configureCell(user: model)
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserContactDetailsTableViewCell.identifier,
                for: indexPath
            ) as? UserContactDetailsTableViewCell else {
                return UITableViewCell()
            }
            let model = viewModel.user(at: indexPath.row - 1)
            cell.configureCell(cellModel: model)
            return cell
            
        }
    }
    
}
