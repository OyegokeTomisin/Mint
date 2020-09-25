//
//  GitHubRequest.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

struct GitHubRequest {
    private let router = Router<GitHubAPI>()

    func fetchCommit(upto limit: Int, completion: @escaping (Result<[GitCommitResponse], Error>) -> Void) {
        router.request(.fetchCommits(limit: limit), completion: completion)
    }
}
