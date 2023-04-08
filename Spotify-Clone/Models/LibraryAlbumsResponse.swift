//
//  LibraryAlbumsResponse.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 8.04.2023.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
