//
//  HapticsManager.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 1.10.2022.
//

import Foundation
import UIKit

final class HapticsManager{
    static let shared = HapticsManager()
    
    private init(){}
    
    public func vibrateForSelection(){
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
