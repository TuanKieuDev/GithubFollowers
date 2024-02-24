//
//  UIImage+.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 24/02/2024.
//

import UIKit

extension UIImageView {
    func applyCircleImage() {
        layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

