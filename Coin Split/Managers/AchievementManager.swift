//
//  AchievementManager.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation

class AchievementManager {
    static let shared = AchievementManager()
    
    private init() {}
    
    func checkAchievements(for split: Split) {
        let dataManager = DataManager.shared
        var profile = dataManager.profile
        var achievementsUpdated = false
        
        // Первый расчёт
        if !profile.achievements[0].isUnlocked && profile.totalSplits >= 1 {
            profile.achievements[0].isUnlocked = true
            profile.achievements[0].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Справедливость - поровну между 2+ людьми
        if !profile.achievements[1].isUnlocked && split.splitMode == Split.SplitMode.equal && split.participantCount >= 2 {
            profile.achievements[1].isUnlocked = true
            profile.achievements[1].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Математик - использовал проценты
        if !profile.achievements[2].isUnlocked && split.splitMode == Split.SplitMode.percentage {
            profile.achievements[2].isUnlocked = true
            profile.achievements[2].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Щедрый - чаевые больше 15%
        if !profile.achievements[3].isUnlocked && split.tipPercentage > 15 {
            profile.achievements[3].isUnlocked = true
            profile.achievements[3].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Историк - первый сохранённый расчёт
        if !profile.achievements[4].isUnlocked && dataManager.splits.count >= 1 {
            profile.achievements[4].isUnlocked = true
            profile.achievements[4].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Архивариус - 10 расчётов в истории
        if !profile.achievements[5].isUnlocked && dataManager.splits.count >= 10 {
            profile.achievements[5].isUnlocked = true
            profile.achievements[5].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Гибкость - использовал ручной ввод
        if !profile.achievements[6].isUnlocked && split.splitMode == Split.SplitMode.manual {
            profile.achievements[6].isUnlocked = true
            profile.achievements[6].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        if achievementsUpdated {
            dataManager.updateProfile(profile)
        }
    }
}

