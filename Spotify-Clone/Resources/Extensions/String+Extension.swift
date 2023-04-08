//
//  String+Extension.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 21.03.2023.
//

import Foundation

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}
