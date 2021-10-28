//
//  User.swift
//  GItHubAPI-Practice
//
//  Created by 大西玲音 on 2021/10/29.
//

import Foundation

struct User: Codable {
    let avatarUrl: String
    let name: String
}

struct UserRepository: Codable {
    let name: String
}

struct UserCommit: Codable {
    let commit: CommitItem
}

struct CommitItem: Codable {
    let author: Author
}

struct Author: Codable {
    let date: String
}
