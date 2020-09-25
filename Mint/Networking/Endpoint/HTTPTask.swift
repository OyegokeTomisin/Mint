//
//  HTTPTask.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request
    case requestParameters(bodyEncoding: ParameterEncoding, bodyParameters: Parameters? = nil,
        urlParameters: Parameters? = nil, headerParameters: HTTPHeaders? = nil)
}
