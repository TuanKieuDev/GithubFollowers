//
//  NoInternetViewController.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 24/02/2024.
//

import UIKit

final class NoInternetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func reconnectAppTapped(_ sender: Any) {
        if InternetManager.shared.isInternetAvailable() {
                    if let delegate = UIApplication.shared.delegate as? AppDelegate {
                        delegate.restartApp()
                    }
                }
    }
}
