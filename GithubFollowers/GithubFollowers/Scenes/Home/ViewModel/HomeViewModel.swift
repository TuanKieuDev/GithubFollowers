//
//  HomeViewModel.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 23/02/2024.
//

import Foundation

final class HomeViewModel {
    
    var isLoading: Observable<Bool> = Observable(value: false)
    var cellDataSource: Observable<[User]> = Observable(value: nil)
    var users: [User] = []
    
    func getUsers(page: Int) {
        
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        
        APICaller.shared.getUsers(page: page) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.isLoading.value = false
            
            switch result {
            case .success(let usersData):
                self.users.append(contentsOf: usersData)
                self.cellDataSource.value = self.users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
