//
//  RecommendationsResponse.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 23.10.2022.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
