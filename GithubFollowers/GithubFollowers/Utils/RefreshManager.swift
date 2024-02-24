//
//  RefreshManager.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 24/02/2024.
//

import UIKit

struct RefreshManager {
    static var shared = RefreshManager()

    private init() {}

    func setupRefreshControl(_ refresh: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: refresh, for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }
}
