//
//  MovieModel.swift
//  MovieStar
//
//  Created by Subhosting's MacBook Pro on 21/08/24.
//

import Foundation

// MARK: - Movie

class Movie: Codable {

    let title: String
    let year: String?
    let imdbId: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

}

// MARK: - Helpers

extension Movie {

    var hasPoster: Bool {
        guard let poster = poster else { return false }
        return !poster.isEmpty && poster != "N/A"
    }

}

// MARK: - Movie Search

class MovieSearch: Decodable {
    let search: [Movie]?
    let errorMessage: String?
    private let responseString: String
    private let totalResultsString: String?

    enum CodingKeys: String, CodingKey {
        case responseString = "Response"
        case search = "Search"
        case errorMessage = "Error"
        case totalResultsString = "totalResults"
    }
}

// MARK: - Helpers

extension MovieSearch {

    var response: Bool { responseString == "True" }

    var totalResults: Int? {
        guard let str = totalResultsString else {
            return nil
        }

        return Int(str)
    }

}
