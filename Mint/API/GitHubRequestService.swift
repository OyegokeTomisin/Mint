//
//  GitHubRequestService.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

protocol GitCommitRequestProtocol: class {
    func didCompleteFetchWithSuccess(commits: [GitCommitResponse])
    func didCompleteFetchWithError(message: String)
}

struct GitHubRequestService {

    private var request = GitHubRequest()
    weak var delegate: GitCommitRequestProtocol?

    func fetchCommit(with fetchLimit: Int = 25) {
        request.fetchCommit(upto: fetchLimit) { (result) in
            switch result {
            case .success(let response):
                self.delegate?.didCompleteFetchWithSuccess(commits: response)
            case .failure(let response):
                self.delegate?.didCompleteFetchWithError(message: response.localizedDescription)
            }
        }
    }
}
