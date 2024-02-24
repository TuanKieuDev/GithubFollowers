//
//  UIView+.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 24/02/2024.
//

import UIKit

extension UIView {
    func applyShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}
