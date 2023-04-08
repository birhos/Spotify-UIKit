//
//  SearchResult.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 29.03.2023.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
