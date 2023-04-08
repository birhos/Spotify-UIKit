//
//  SettingsModel.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 8.10.2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
