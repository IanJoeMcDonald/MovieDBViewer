//
//  NetworkManagerExtensions.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 05/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import Foundation

//MARK: Extension: Results and Errors
extension NetworkManager {
    struct Results<T> {
        var data: T?
        var error: Error?
        
        init(data: T? = nil, error: Error?) {
            self.data = data
            self.error = error
        }
    }
    
    enum CustomError: Error {
        case callGetShow
        case callGetConfiguration
        case callGetGenre
        case callGetLanguages
        case noData
        case jsonConversion
        case jsonParsing
    }
}

//MARK: Extension: Localized Error
extension NetworkManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .callGetShow:
            return String(Error: .callGetShow)
        case .callGetConfiguration:
            return String(Error: .callGetConfiguration)
        case .callGetGenre:
            return String(Error: .callGetGenre)
        case .callGetLanguages:
            return String(Error: .callGetLanguages)
        case .noData:
            return String(Error: .noData)
        case .jsonConversion:
            return String(Error: .jsonConversion)
        case .jsonParsing:
            return String(Error: .jsonParsing)
        }
    }
}
