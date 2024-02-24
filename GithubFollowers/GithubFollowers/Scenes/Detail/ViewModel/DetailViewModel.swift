//
//  DetailViewModel.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 23/02/2024.
//

import Foundation

final class DetailViewModel {
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    var isLoading: Observable<Bool> = Observable(value: false)
    var userDataObservable: Observable<User> = Observable(value: nil)
    var userDetail: User?
    
    func getUserDetail() {
        
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        
        APICaller.shared.getUserDetail(url: url) { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let userDetail):
                self?.userDetail = userDetail
                self?.mapData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func mapData() {
        self.userDataObservable.value = self.userDetail
    }
}
