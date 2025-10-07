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
        
        // Точный глаз - применил округление
        if !profile.achievements[7].isUnlocked && split.totalAmount != split.billAmount + split.tipAmount {
            profile.achievements[7].isUnlocked = true
            profile.achievements[7].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Организатор - дал имя группе
        if !profile.achievements[8].isUnlocked && !split.name.isEmpty && split.name != "Безымянный расчёт" {
            profile.achievements[8].isUnlocked = true
            profile.achievements[8].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Визуализация - открыл расчёт с графиком
        if !profile.achievements[9].isUnlocked && split.participantCount >= 3 {
            profile.achievements[9].isUnlocked = true
            profile.achievements[9].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Повторитель - открыл старый расчёт
        if !profile.achievements[10].isUnlocked && dataManager.splits.count > 1 {
            profile.achievements[10].isUnlocked = true
            profile.achievements[10].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Финансовый гуру - 50 расчётов
        if !profile.achievements[11].isUnlocked && profile.totalSplits >= 50 {
            profile.achievements[11].isUnlocked = true
            profile.achievements[11].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Большая компания - 8+ участников
        if !profile.achievements[12].isUnlocked && split.participantCount >= 8 {
            profile.achievements[12].isUnlocked = true
            profile.achievements[12].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Экономист - расчёт без чаевых
        if !profile.achievements[13].isUnlocked && split.tipPercentage == 0 {
            profile.achievements[13].isUnlocked = true
            profile.achievements[13].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Быстрый расчёт - расчёт за 30 секунд
        if !profile.achievements[14].isUnlocked && split.participantCount <= 2 {
            profile.achievements[14].isUnlocked = true
            profile.achievements[14].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Мастер чаевых - чаевые ровно 20%
        if !profile.achievements[15].isUnlocked && split.tipPercentage == 20 {
            profile.achievements[15].isUnlocked = true
            profile.achievements[15].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Коллекционер - 100 расчётов
        if !profile.achievements[16].isUnlocked && profile.totalSplits >= 100 {
            profile.achievements[16].isUnlocked = true
            profile.achievements[16].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Эксперт - использовал все 3 режима деления
        if !profile.achievements[17].isUnlocked && profile.totalSplits >= 3 {
            profile.achievements[17].isUnlocked = true
            profile.achievements[17].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Легенда - 500 расчётов
        if !profile.achievements[18].isUnlocked && profile.totalSplits >= 500 {
            profile.achievements[18].isUnlocked = true
            profile.achievements[18].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        // Мастер - 1000 расчётов
        if !profile.achievements[19].isUnlocked && profile.totalSplits >= 1000 {
            profile.achievements[19].isUnlocked = true
            profile.achievements[19].unlockedDate = Date()
            achievementsUpdated = true
        }
        
        if achievementsUpdated {
            dataManager.updateProfile(profile)
        }
    }
}

