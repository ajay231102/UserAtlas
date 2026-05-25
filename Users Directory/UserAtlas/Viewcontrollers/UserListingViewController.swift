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
    var viewModel: UserListingViewModel!
    
    public static func getInstance(model: UserListingViewModel) -> UserListingViewController {
        let vc: UserListingViewController = UserListingViewController.loadFromNib()
        vc.viewModel = model
        return vc
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        bindViewModel()
        viewModel.fetchUsers()
    }
    
    private func setupUI() {
        self.lblHeader.font = UIFont(name: Constants.FontNames.CabinetBold, size: 18)
        self.lblDescription.font = UIFont(name: Constants.FontNames.ProximaSemiBold, size: 12)
        self.settingIconContainerView.layer.cornerRadius = self.settingIconContainerView.bounds.height / 2
        self.searchBarContainerView.layer.cornerRadius = self.searchBarContainerView.bounds.height / 2
    }
    
    private func setupTableView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(
            UINib(nibName: "UserListTableViewCell", bundle: nil),
            forCellReuseIdentifier: UserListTableViewCell.identifier
        )
        
        tblView.separatorStyle = .none
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 100
    }
    
    private func bindViewModel() {
        viewModel.onDataReload = { [weak self] in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
        
        viewModel.onError = { errorMessage in
            print(errorMessage)
        }
        viewModel.onLoadingStateChange = { isLoading in
            print("Loading: \(isLoading)")
        }
    }
    
    @IBAction func settingsBtnTapped(_ sender: Any) {
    }
}

extension UserListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserListTableViewCell.identifier,
            for: indexPath
        ) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        let user = viewModel.user(at: indexPath.row)
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = viewModel.user(at: indexPath.row)
        let model = UserDetailsViewModel(user: user)
        let vc = UserDetailViewController.getInstance(model: model)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
