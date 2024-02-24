//
//  HomeViewController.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 23/02/2024.
//

import UIKit

final class HomeViewController: UIViewController, Bindable {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: HomeViewModel!
    
    var usersData: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        viewModel.getUsers()
    }
    
    private func configView() {
        self.title = Constant.Title.home
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: Constant.NibName.userCell)
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] users in
            guard let self = self, let users = users else {
                return
            }
            
            self.usersData = users
            self.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func openDetail(url: String) {
        let detailViewModel = DetailViewModel(url: url)
        let detailVC = DetailViewController(viewModel: detailViewModel)
        detailVC.bindViewModel(to: detailViewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.userCellHeight
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.NibName.userCell, for: indexPath) as? UserTableViewCell {
            if let user = self.usersData?[indexPath.row] {
                cell.configCell(user: user)
                cell.goDetail = {
                    self.openDetail(url: user.url ?? "")
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
}
