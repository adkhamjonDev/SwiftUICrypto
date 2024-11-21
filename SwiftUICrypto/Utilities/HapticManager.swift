//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 21/11/24.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type:UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
