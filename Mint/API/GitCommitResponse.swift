//
//  GitCommitResponse.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

struct GitCommitResponse: Codable {
    let commit: Commit?
    let author: Author?
}

struct Commit: Codable {
    let author: Author?
}

struct Author: Codable {
    let name: String?
    let date: String?
    let email: String?
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case name, date, email
        case avatarUrl = "avatar_url"
    }
}
