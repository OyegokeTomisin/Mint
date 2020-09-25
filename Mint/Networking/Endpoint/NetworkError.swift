//
//  NetworkError.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

enum NetworkError: String, Error, LocalizedError {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case incompleteRequest = "Failed to complete request."
    case unknownError = "Something went wrong."

    public var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: "Network Error")
    }
}
