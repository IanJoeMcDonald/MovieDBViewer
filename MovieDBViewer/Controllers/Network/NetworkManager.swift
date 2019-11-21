//
//  NetworkManager.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 22/10/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

final class NetworkManager {
    //MARK: Static Constants
    static let shared = NetworkManager()
    
    //MARK: Private Vars
    private var posterPath:String?
    
    //MARK: Private Constants
    private let rest = RESTfulManager()
    
    //MARK: Public Functions
    func fetchShows(from Url: URLString, completion: @escaping (Results<[Show]>)->Void) {
        fetchConfiguration {[weak self] (_) in
            guard let url = URL(string: Url.rawValue) else { return }
            self?.rest.queryParams.add(key: MovieStrings.apiKey.rawValue, value: Api.key.rawValue)
            self?.rest.makeRequest(to: url, method: .GET) { (results) in
                if let _ = results.error {
                    completion(Results(error: CustomError.callGetShow))
                    return
                }
                
                guard let data = results.data else {
                    completion(Results(error: CustomError.noData))
                    return
                }
                
                do {
                    let JSONroot = try JSONSerialization.jsonObject(with: data)
                    
                    guard let JSONdictionary = JSONroot as? [String: Any] else {
                        completion(Results(error: CustomError.jsonParsing))
                        return
                    }
                    guard let JSONarray = JSONdictionary[String(JSON: .results)] as? [[String:Any]]
                        else {
                            completion(Results(error: CustomError.jsonParsing))
                            return
                    }
                    
                    var movies = [Show]()
                    
                    for data in JSONarray {
                        if let movie = Show(json: data) {
                            movies.append(movie)
                        }
                    }
                    completion(Results(data: movies, error: nil))
                } catch {
                    completion(Results(error: CustomError.jsonConversion))
                    return
                }
            }
        }
    }
    
    func fetchConfiguration(completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: URLString.configuration.rawValue) else { return }
        rest.queryParams.add(key: MovieStrings.apiKey.rawValue, value: Api.key.rawValue)
        rest.makeRequest(to: url, method: .GET) { [weak self] (results) in
            if let _ = results.error {
                completion(CustomError.callGetConfiguration)
                return
            }
            
            guard let data = results.data else {
                completion(CustomError.noData)
                return
            }
            
            do {
                let JSONroot = try JSONSerialization.jsonObject(with: data)
                
                guard let JSONdictionary = JSONroot as? [String:Any] else {
                    completion(CustomError.jsonParsing)
                    return
                }
                
                guard let JSONimages = JSONdictionary[String(JSON: .images)] as? [String:Any] else {
                    completion(CustomError.jsonParsing)
                    return
                }
                guard let defaultURL = JSONimages[String(JSON: .baseURL)] as? String  else {
                    completion(CustomError.jsonParsing)
                    return
                }
                
                guard let posterSizes = JSONimages[String(JSON: .posterSizes)] as? [String] else {
                    completion(CustomError.jsonParsing)
                    return
                }
                guard let posterSize = self?.selectPosterSize() else {
                    completion(CustomError.jsonParsing)
                    return
                }
                
                self?.posterPath = defaultURL + posterSizes[posterSize]
                completion(nil)
            } catch {
                completion(CustomError.jsonConversion)
            }
        }
    }
    
    func fetchGenres(completion: @escaping (Results<[Int:String]>) -> Void) {
        guard let url = URL(string: URLString.genres.rawValue) else { return }
        rest.queryParams.add(key: MovieStrings.apiKey.rawValue, value: Api.key.rawValue)
        rest.makeRequest(to: url, method: .GET) { (results) in
            
            if let _ = results.error {
                completion(Results(error: CustomError.callGetGenre))
                return
            }
            
            guard let data = results.data else {
                completion(Results(error: CustomError.noData))
                return
            }
            
            do {
                let JSONroot = try JSONSerialization.jsonObject(with: data)
                
                guard let JSONdictionary = JSONroot as? [String:Any] else {
                    completion(Results(error: CustomError.jsonParsing))
                    return
                }
                guard let JSONgenres = JSONdictionary[String(JSON: .genres)] as? [[String:Any]] else
                {
                    completion(Results(error: CustomError.jsonParsing))
                    return
                }
                
                var genres = [Int:String]()
                
                for genre in JSONgenres {
                    guard let id = genre[MovieStrings.id.rawValue] as? Int,
                        let name = genre[MovieStrings.name.rawValue] as? String else {
                            continue
                    }
                    genres[id] = name
                }
                completion(Results(data: genres, error: nil))
            } catch {
                completion(Results(error: CustomError.jsonConversion))
            }
        }
    }
    
    func fetchLanguages(completion: @escaping(Results<[String:String]>) ->Void) {
        guard let url = URL(string: URLString.languages.rawValue) else { return }
        rest.queryParams.add(key: MovieStrings.apiKey.rawValue, value: Api.key.rawValue)
        rest.makeRequest(to: url, method: .GET) { (results) in
            
            if let _ = results.error {
                completion(Results(error: CustomError.callGetLanguages))
                return
            }
            
            guard let data = results.data else {
                completion(Results(error: CustomError.noData))
                return
            }
            
            do {
                let JSONroot = try JSONSerialization.jsonObject(with: data)
                
                guard let JSONdictionary = JSONroot as? [[String:Any]] else {
                    completion(Results(error: CustomError.jsonParsing))
                    return
                }
                
                var languages = [String:String]()
                
                for language in JSONdictionary {
                    guard let id = language[MovieStrings.iso639.rawValue] as? String,
                        let name = language[MovieStrings.englishName.rawValue] as? String else {
                            continue
                    }
                    languages[id] = name
                }
                completion(Results(data: languages, error: nil))
            } catch {
                completion(Results(error: CustomError.jsonConversion))
            }
        }
    }
    
    func fetchImage(from string: String, completion: @escaping (UIImage?) -> Void) {
        let urlSession = URLSession.shared
        guard let posterPath = posterPath else {
            completion(nil)
            return
        }
        if let url = URL(string: posterPath + string) {
            let urlRequest = URLRequest(url:url)
            let task = urlSession.dataTask(with: urlRequest) {
                (data, _, error) in
                guard error == nil else {
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
            
            task.resume()
        }
    }
    
    //MARK: Private Functions
    private func selectPosterSize() -> Int {
        return UIDevice.current.userInterfaceIdiom == .pad ? 5 : 4
    }
}
