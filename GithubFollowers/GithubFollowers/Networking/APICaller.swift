//
//  APICaller.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 23/02/2024.
//

import Foundation

enum  APIError: Error {
    case urlError
    case parseJSONError
}

final class APICaller {
    
    static let shared = APICaller()
    
    func getUsers(page: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        
        guard let url = URL(string: "\(Endpoint.testURL)&page=\(page)") else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
                        
            do {
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(UsersList.self, from: data)
                completion(.success(results.items))
            } catch {
                completion(.failure(APIError.parseJSONError))
            }
            
        }
        task.resume()
    }
    
    func getUserDetail(url: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
                        
            do {
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(User.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.parseJSONError))
            }
            
        }
        task.resume()
    }
}
