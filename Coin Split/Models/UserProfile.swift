//
//  UserProfile.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation

struct UserProfile: Codable {
    var name: String
    var avatar: String // Первая буква имени
    var totalSplits: Int
    var totalAmount: Double
    var achievements: [Achievement]
    
    static let defaultProfile = UserProfile(
        name: "Александр",
        avatar: "A",
        totalSplits: 0,
        totalAmount: 0,
        achievements: Achievement.allAchievements
    )
    
    var unlockedAchievementsCount: Int {
        achievements.filter { $0.isUnlocked }.count
    }
}

