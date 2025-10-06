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
            return UserProfile.defaultProfile
        }
        return decoded
    }
    
    // MARK: - Settings
    
    func updateSettings(_ newSettings: AppSettings) {
        settings = newSettings
        saveSettings()
        
        // Обновляем менеджеры при изменении настроек
        LocalizationManager.shared.setLanguage(newSettings.language)
        ThemeManager.shared.setTheme(newSettings.theme)
        TextSizeManager.shared.setTextSize(newSettings.textSize)
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
}

