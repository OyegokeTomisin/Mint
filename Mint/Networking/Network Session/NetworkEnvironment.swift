//
//  NetworkEnvironment.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case dev
    
    var baseURL: String {
        switch self {
        case .dev: return "https://api.github.com/repos/rails/rails/"
        }
    }
}
