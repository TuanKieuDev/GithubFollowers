//
//  User.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 23/02/2024.
//

import Foundation

struct UsersList: Codable {
    var items: [User]
}

struct User: Codable {
    let login: String
    let id: Int
    let avatarURL: String?
    let url: String?
    let htmlURL: String?
    var name: String?
    let followersURL: String?
    let followingURL: String?
    var location: String?
    var bio: String?
    var followers: Int?
    var following: Int?
    var publicRepos: Int?

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case location
        case bio
        case followers
        case following
        case publicRepos = "public_repos"
    }
}
