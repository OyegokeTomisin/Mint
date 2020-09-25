//
//  GitHubAPI.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

enum GitHubAPI {
    case fetchCommits(limit: Int)
}

extension GitHubAPI: EndPointType {
    var path: String {
        switch self {
        case .fetchCommits:
            return "commits"
        }
    }

    var task: HTTPTask {
        switch self {
        case .fetchCommits(let limit):
            let params = ["per_page": limit]
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params)
        }
    }

    var headers: HTTPHeaders? { nil }

    var httpMethod: HTTPMethod { .get }
}
