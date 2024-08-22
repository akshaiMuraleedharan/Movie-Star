//
//  Poster.swift
//  MovieStar
//
//  Created by Subhosting's MacBook Pro on 22/08/24.
//

import Foundation

// MARK: - Poster

class Poster: Codable {
    let imdbId: String
    let imageData: Data

    init(imdbId: String, imageData: Data) {
        self.imdbId = imdbId
        self.imageData = imageData
    }
}

