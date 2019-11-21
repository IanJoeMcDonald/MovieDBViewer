//
//  RESTfulManager.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 22/10/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import Foundation

final class RESTfulManager {
    //MARK: Public Variables
    var requestHeaders = RESTfulEntity()
    var queryParams = RESTfulEntity()
    var bodyParams = RESTfulEntity()
    var session = URLSession(configuration:URLSessionConfiguration.default)
    
    //MARK: Public Functions
    func makeRequest(to url: URL, method: Method, completion:
        @escaping (_ result: Results) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let targetUrl = self?.addQueryParameters(url: url)
            let httpBody = self?.getHttpBody(method: method)
            guard let request = self?.prepareHttpRequest(url: targetUrl,
                                                         httpBody: httpBody,
                                                         method: method) else {
                completion(Results(error: CustomError.failedToCreateRequest))
                return
            }
            let task = self?.session.dataTask(with: request) {
                (data, response, error) in
                completion(Results(data: data,
                                   response: HttpResponse(urlResponse:
                                    response),
                                   error: error))
            }
            task?.resume()
            
        }
    }
    
    func getData(from url: URL, completion: @escaping(_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let task = self?.session.dataTask(with: url) { (data, _, _) in
                guard let data = data else {
                    completion(nil)
                    return
                }
                completion(data)
            }
            task?.resume()
        }
        
    }
    
    //MARK: Private Functions
    private func addQueryParameters(url: URL) -> URL {
        if queryParams.pairsCount() == 0 {
            return url
        }
        
        guard var urlComponents = URLComponents(url: url,
                                                resolvingAgainstBaseURL: false)
            else { return url}
        urlComponents.queryItems = generateQueryItems()
        
        guard let updatedURL = urlComponents.url else { return url}
        return updatedURL
    }
    
    private func getHttpBody(method: Method) -> Data? {
        if method == .GET {
            return nil
        }
        
        return try? JSONSerialization.data(withJSONObject:
            bodyParams.allPairs(), options: [.prettyPrinted, .sortedKeys])
    }
    
    private func prepareHttpRequest(url: URL?, httpBody: Data?,
                                    method: Method) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        for (key, value) in requestHeaders.allPairs() {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = httpBody
        return request
    }
    
    private func generateQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        for (key, value) in queryParams.allPairs() {
            let queryItem = URLQueryItem(name: key, value:
                value.addingPercentEncoding(withAllowedCharacters:
                    .urlQueryAllowed))
            queryItems.append(queryItem)
        }
        return queryItems
    }
    
}

//MARK: Extension for Structs/Enums
extension RESTfulManager {
    
    //MARK: Enums
    enum Method : String {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }
    
    enum CustomError: Error {
        case failedToCreateRequest
    }
    
    //MARK: Structs
    struct RESTfulEntity {
        
        private var keyValuePairs = [String: String]()
        
        mutating func add(key: String, value: String) {
            keyValuePairs[key] = value
        }
        
        func valueFor(_ key: String) -> String? {
            return keyValuePairs[key]
        }
        
        func allPairs() -> [String: String] {
            return keyValuePairs
        }
        
        func pairsCount() -> Int {
            return keyValuePairs.count
        }
    }
    
    struct HttpResponse {
        var statusCode = 0
        var headers = RESTfulEntity()
        
        init(urlResponse: URLResponse?) {
            guard let response = urlResponse else { return }
            
            let weakHttpResponse = response as? HTTPURLResponse
            guard let httpResponse = weakHttpResponse else {
                return
            }
            
            statusCode = httpResponse.statusCode
            
            let stringHeaders = httpResponse.allHeaderFields
                as? [String:String] ?? [:]
            
            for (key, value) in stringHeaders {
                headers.add(key: key, value: value)
            }
        }
    }
    
    struct Results {
        var data: Data?
        var response: HttpResponse?
        var error: Error?
        
        init(data: Data? = nil, response: HttpResponse? = nil, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
    }
}

//MARK: Extension: Localized Error
extension RESTfulManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest:
          return String(Error: .failedRequest)
        }
    }
}

