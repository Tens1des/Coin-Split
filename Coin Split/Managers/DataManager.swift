//
//  DataManager.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var splits: [Split] = []
    @Published var profile: UserProfile
    @Published var settings: AppSettings
    
    private let splitsKey = "splits_data"
    private let profileKey = "profile_data"
    private let settingsKey = "settings_data"
    
    init() {
        self.splits = DataManager.loadSplits()
        self.profile = DataManager.loadProfile()
        self.settings = DataManager.loadSettings()
        
        // Инициализируем менеджеры
        setupManagers()
        
        // Гарантируем, что профиль содержит актуальный набор достижений
        self.profile.achievements = DataManager.mergeAchievements(
            existing: self.profile.achievements,
            withTemplates: Achievement.allAchievements
        )
        saveProfile()
    }
    
    private func setupManagers() {
        // Настраиваем локализацию
        LocalizationManager.shared.setLanguage(settings.language)
        
        // Настраиваем тему
        ThemeManager.shared.setTheme(settings.theme)
        
        // Настраиваем размер текста
        TextSizeManager.shared.setTextSize(settings.textSize)
    }
    
    // MARK: - Splits
    
    func addSplit(_ split: Split) {
        splits.insert(split, at: 0)
        profile.totalSplits += 1
        profile.totalAmount += split.totalAmount
        saveSplits()
        saveProfile()
        
        // Проверка достижений
        AchievementManager.shared.checkAchievements(for: split)
    }
    
    func deleteSplit(_ split: Split) {
        if let index = splits.firstIndex(where: { $0.id == split.id }) {
            splits.remove(at: index)
            saveSplits()
        }
    }
    
    func deleteAllSplits() {
        splits.removeAll()
        saveSplits()
    }
    
    private func saveSplits() {
        if let encoded = try? JSONEncoder().encode(splits) {
            UserDefaults.standard.set(encoded, forKey: splitsKey)
        }
    }
    
    private static func loadSplits() -> [Split] {
        guard let data = UserDefaults.standard.data(forKey: "splits_data"),
              let decoded = try? JSONDecoder().decode([Split].self, from: data) else {
            return []
        }
        return decoded
    }
    
    // MARK: - Profile
    
    func updateProfile(_ newProfile: UserProfile) {
        profile = newProfile
        saveProfile()
    }
    
    func saveProfile() {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: profileKey)
        }
    }
    
    private static func loadProfile() -> UserProfile {
        guard let data = UserDefaults.standard.data(forKey: "profile_data"),
              let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            // Возвращаем профиль по умолчанию с актуальным списком ачивок
            var def = UserProfile.defaultProfile
            def.achievements = Achievement.allAchievements
            return def
        }
        // Миграция достижений до актуального списка
        var migrated = decoded
        migrated.achievements = mergeAchievements(existing: decoded.achievements, withTemplates: Achievement.allAchievements)
        return migrated
    }
    
    // MARK: - Settings
    
    func updateSettings(_ newSettings: AppSettings) {
        settings = newSettings
        saveSettings()
        
        // Обновляем менеджеры при изменении настроек
        LocalizationManager.shared.setLanguage(newSettings.language)
        ThemeManager.shared.setTheme(newSettings.theme)
        TextSizeManager.shared.setTextSize(newSettings.textSize)
        
        // Обновляем локализованные заголовки/иконки ачивок (сохраняя прогресс)
        profile.achievements = DataManager.mergeAchievements(
            existing: profile.achievements,
            withTemplates: Achievement.allAchievements
        )
        saveProfile()
    }
    
    private func saveSettings() {
        if let encoded = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encoded, forKey: settingsKey)
        }
    }
    
    private static func loadSettings() -> AppSettings {
        guard let data = UserDefaults.standard.data(forKey: "settings_data"),
              let decoded = try? JSONDecoder().decode(AppSettings.self, from: data) else {
            return AppSettings.defaultSettings
        }
        return decoded
    }

    // MARK: - Achievements migration
    private static func mergeAchievements(existing: [Achievement], withTemplates templates: [Achievement]) -> [Achievement] {
        let existingById: [String: Achievement] = Dictionary(uniqueKeysWithValues: existing.map { ($0.id, $0) })
        // Пробегаемся по актуальным шаблонам и переносим статус из существующих
        let merged: [Achievement] = templates.map { template in
            if let old = existingById[template.id] {
                return Achievement(
                    id: template.id,
                    title: template.title, // локализованный заголовок из текущего словаря
                    description: template.description,
                    icon: template.icon,
                    isUnlocked: old.isUnlocked,
                    unlockedDate: old.unlockedDate
                )
            } else {
                return template
            }
        }
        return merged
    }
}

