//
//  UserTableViewCell.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 23/02/2024.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var linkLabel: UILabel!
    
    var goDetail: (() -> Void)?
    
    static func nib() -> UINib {
        return UINib(nibName: Constant.NibName.userCell, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(user: User?) {
        nameLabel.text = user?.login
        linkLabel.text = user?.htmlURL
        
        let backgroundQueue = DispatchQueue.global(qos: .background)
        
        backgroundQueue.async {
            guard let url = URL(string: user?.avatarURL ?? "") else {
                return
            }
            
            ImageProvider.shared.fetchData(url: url) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.avatarImageView.image = image
                }
            }
        }
        
        setClickableLink()
        makeViewTappable()
    }
    
    private func setClickableLink() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openLink))
        
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(tap)
        linkLabel.underline()
        linkLabel.textColor = .systemOrange
    }
    
    @objc
    private func openLink() {
        if let openLink = URL(string: linkLabel.text ?? "https://github.com/") {
            if UIApplication.shared.canOpenURL(openLink) {
                UIApplication.shared.open(openLink, options: [:])
            }
        }
    }
    
    private func makeViewTappable() {
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(self.handleCellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleCellTapped(sender : UITapGestureRecognizer) {
        goDetail?()
    }
}
