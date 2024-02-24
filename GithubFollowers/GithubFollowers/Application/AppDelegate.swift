//
//  AppDelegate.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 22/02/2024.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeViewController()
        homeVC.bindViewModel(to: HomeViewModel())
        let navigationController = UINavigationController(rootViewController: homeVC)
        //        window.rootViewController = navigationController
        
        let hasInternet = InternetManager.shared.isInternetAvailable()
        window.rootViewController = hasInternet ? navigationController : NoInternetViewController()
        
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    func restartApp() {
        let homeVC = HomeViewController()
        homeVC.bindViewModel(to: HomeViewModel())
        window?.rootViewController = UINavigationController(rootViewController: homeVC)
        window?.makeKeyAndVisible()
    }
}

