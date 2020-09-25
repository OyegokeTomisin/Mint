//
//  Router.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion<T> = (Result<T, Error>) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<T: Codable>(_ route: EndPoint, completion: @escaping NetworkRouterCompletion<T>)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {

    private var task: URLSessionTask?

    init() { }

    func request<T>(_ route: EndPoint, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                self.handleNetworkResponse(data, response, error, route: route, completion: { completion($0) })
            })
        } catch {
            handleNetworkResponse(nil, nil, error, route: route, completion: { completion($0) })
        }
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }
}

extension Router {

    // MARK: - URL Request Builder
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path))
        request.httpMethod = route.httpMethod.rawValue
        addDefaultHeaders(request: &request)
        do {
            switch route.task {
            case .request:
                break
            case .requestParameters(let bodyEncoding, let bodyParameters, let urlParameters, let headerParameters):
                try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
                addAdditionalHeaders(headerParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    // MARK: - Parameter Encoding
    private func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }

    // MARK: - URL Request Headers
    private func addDefaultHeaders(request: inout URLRequest) {

        request.setValue("application/json", forHTTPHeaderField: "Accept")

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    // MARK: - Handle Network Response
    private func handleNetworkResponse<T: Codable>( _ data: Data?, _ response: URLResponse?, _ error: Error?, route: EndPoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard error == nil, let data = data else {
            completion(.failure(error ?? NetworkError.incompleteRequest))
            return
        }
        decodeData(data, completion)
    }
    
    private func decodeData<T: Codable>(_ data: Data, _ completion: (Result<T, Error>) -> Void) {
        do {
            let response  = try JSONDecoder().decode(T.self, from: data)
            completion(.success(response))
        } catch let error {
            completion( .failure(error))
        }
    }
}
