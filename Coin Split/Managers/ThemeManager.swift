//
//  ThemeManager.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var currentTheme: AppSettings.Theme = .light
    @Published var colorScheme: ColorScheme = .light
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        setupThemeObserver()
    }
    
    private func setupThemeObserver() {
        $currentTheme
            .sink { [weak self] theme in
                self?.updateColorScheme(for: theme)
            }
            .store(in: &cancellables)
    }
    
    func setTheme(_ theme: AppSettings.Theme) {
        currentTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: "selected_theme")
    }
    
    private func updateColorScheme(for theme: AppSettings.Theme) {
        switch theme {
        case .light:
            colorScheme = .light
        case .dark:
            colorScheme = .dark
        case .auto:
            // Используем системную тему
            colorScheme = UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
        }
    }
    
    func loadSavedTheme() {
        if let savedTheme = UserDefaults.standard.string(forKey: "selected_theme"),
           let theme = AppSettings.Theme(rawValue: savedTheme) {
            setTheme(theme)
        }
    }
}

// MARK: - Color Extensions for Theme Support

extension Color {
    // Основные цвета приложения
    static let appPrimary = Color.purple
    static let appSecondary = Color.blue
    static let appAccent = Color.pink
    
    // Адаптивные цвета для светлой/тёмной темы
    static let adaptiveBackground = Color(UIColor.systemGroupedBackground)
    static let adaptiveCardBackground = Color(UIColor.systemBackground)
    static let adaptiveText = Color(UIColor.label)
    static let adaptiveSecondaryText = Color(UIColor.secondaryLabel)
    static let adaptiveSeparator = Color(UIColor.separator)
    
    // Цвета для карточек
    static let cardBackground = Color.white
    static let cardBackgroundDark = Color(UIColor.secondarySystemBackground)
    
    // Цвета для кнопок
    static let buttonPrimary = Color.purple
    static let buttonSecondary = Color.gray.opacity(0.3)
    static let buttonDestructive = Color.red
    
    // Цвета для аватаров участников
    static let participantBlue = Color.blue
    static let participantPurple = Color.purple
    static let participantPink = Color.pink
    static let participantOrange = Color.orange
    static let participantGreen = Color.green
    static let participantRed = Color.red
    static let participantCyan = Color.cyan
    static let participantYellow = Color.yellow
}
