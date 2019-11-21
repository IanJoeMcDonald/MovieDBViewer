//
//  Show.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/09/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import Foundation

struct Show : Equatable {
    //MARK: Private Set Vars
    private(set) var id:            Int
    private(set) var title:         String
    private(set) var overview:      String
    private(set) var averageVote:   Double?
    private(set) var genreIDs:      [Int]?
    private(set) var posterPath:    String?
    private(set) var language:      String?
    private(set) var date:          String?
    
    //MARK: Static Functions
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }
    
    //MARK: Init
    init?(json: [String:Any]) {
        guard let id = json[MovieStrings.id.rawValue] as? Int,
            let overview = json[MovieStrings.overview.rawValue] as? String else {
                return nil
        }
        
        self.id = id
        self.overview = overview
        
        var possibleTitle: String?
        
        if let title = json[MovieStrings.title.rawValue] as? String {
            possibleTitle = title
        }
        
        if let title = json[MovieStrings.name.rawValue] as? String {
            possibleTitle = title
        }
        
        guard let title = possibleTitle else {
            return nil
        }
        
        self.title = title
        
        if let averageVote = json[MovieStrings.averageVote.rawValue] as? Double {
            //Times 10 to create percentage
            self.averageVote = averageVote * 10
        }
        
        if let genreIDs = json[MovieStrings.genreIDs.rawValue] as? [Int] {
            self.genreIDs = genreIDs
        }
        
        if let posterPath = json[MovieStrings.posterPath.rawValue] as? String {
            self.posterPath = posterPath
        }
        
        if let language = json[MovieStrings.language.rawValue] as? String {
            self.language = language
        }
        
        if let date = json[MovieStrings.date.rawValue] as? String {
            self.date = date
        } else if let date = json[MovieStrings.airDate.rawValue] as? String {
            self.date = date
        }
    }
}
