//
//  StringAssets.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 02/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import Foundation

enum StringAssets : String {
    case movies = "Movies";
    case tv = "TV";
    case nowShowing = "Now Showing";
    case upComming = "Upcomming";
    case topRated = "Top Rated";
    case onAir = "On Air";
    case description = "Description";
    case releaseDate = "Release Date";
    case originalLanguage = "Original Language";
    case genre = "Genre";
    case rating = "Rating";
    case back = "Back";
    case star = "⭐️"
    case terminator = ",\n"
}

enum URLString : String {
    case moviesNowShowing = "https://api.themoviedb.org/3/movie/now_playing"
    case moviesUpcomming = "https://api.themoviedb.org/3/movie/upcoming"
    case moviesTopRated = "https://api.themoviedb.org/3/movie/top_rated"
    case moviesPopular = "https://api.themoviedb.org/3/movie/popular"
    case tvNowShowing = "https://api.themoviedb.org/3/tv/airing_today"
    case tvOnTheAir = "https://api.themoviedb.org/3/tv/on_the_air"
    case tvTopRated = "https://api.themoviedb.org/3/tv/top_rated"
    case tvPopular = "https://api.themoviedb.org/3/tv/popular"
    case configuration = "https://api.themoviedb.org/3/configuration"
    case genres = "https://api.themoviedb.org/3/genre/movie/list"
    case languages = "https://api.themoviedb.org/3/configuration/languages"
}

enum JSONAssets : String {
    case results = "results"
    case images = "images"
    case baseURL = "secure_base_url"
    case posterSizes = "poster_sizes"
    case genres = "genres"
}

enum ErrorAssets : String {
    case callGetShow = "Error calling GET in fetch movie"
    case callGetConfiguration = "Error calling GET in fetch configuration"
    case callGetGenre = "Error calling GET in fecth genre"
    case callGetLanguages = "Error calling GET in fetch languages"
    case noData = "Error did not receive data from API"
    case jsonConversion = "Error converting data to JSON"
    case jsonParsing = "Error parsing JSON data"
    case failedRequest = "Unable to create the URL Request object"
}
