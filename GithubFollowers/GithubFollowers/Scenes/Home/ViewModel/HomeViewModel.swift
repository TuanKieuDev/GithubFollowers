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
    var users: [User]?
    
    func getUsers() {
        
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        
        APICaller.shared.getListUsers { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let usersData):
                self?.users = usersData
                self?.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.users ?? []
    }
}
