//
//  DetailViewController.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 23/02/2024.
//

import UIKit

final class DetailViewController: UIViewController, Bindable {
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var repositoriesLabel: UILabel!
    @IBOutlet private weak var statisticView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: DetailViewModel!
    
    var userData: User?
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: Constant.NibName.detailVC, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getUserDetail()
        configView()
    }
    
    private func configView() {
        self.title = Constant.Title.detail
        
        userImageView.applyCircleImage()
        statisticView.layer.cornerRadius = 20
        statisticView.applyShadow()
    }
    
    private func configData() {
        
        let backgroundQueue = DispatchQueue.global(qos: .background)
        
        backgroundQueue.async { [weak self] in
            if let imageUrl = URL(string: self?.userData?.avatarURL ?? ""),
               let imageData = try? Data(contentsOf: imageUrl),
               let image = UIImage(data: imageData) {
                
                DispatchQueue.main.async { [weak self] in
                    self?.userImageView.image = image
                }
            }
        }
        
        nameLabel.text = userData?.login ?? "-"
        locationLabel.text = userData?.location ?? "-"
        bioLabel.text = userData?.bio
        followersLabel.text = String(describing: userData?.followers ?? 0)
        followingLabel.text = String(describing: userData?.following ?? 0)
        repositoriesLabel.text = String(describing: userData?.publicRepos ?? 0)
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
        
        viewModel.userDataObservable.bind { [weak self] user in
            guard let self = self, let user = user else {
                return
            }
            self.userData = user
            self.configData()
        }
    }
}
