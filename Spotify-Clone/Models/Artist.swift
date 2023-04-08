//
//  Artist.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 1.10.2022.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
