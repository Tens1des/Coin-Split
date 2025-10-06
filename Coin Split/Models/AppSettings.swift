//
//  AppSettings.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation
import SwiftUI

struct AppSettings: Codable {
    var language: Language
    var theme: Theme
    var textSize: TextSize
    
    enum Language: String, Codable, CaseIterable {
        case russian = "ru"
        case english = "en"
        case spanish = "es"
        case german = "de"
        
        var displayName: String {
            switch self {
            case .russian: return "Русский"
            case .english: return "English"
            case .spanish: return "Español"
            case .german: return "Deutsch"
            }
        }
        
        var flag: String {
            switch self {
            case .russian: return "RU"
            case .english: return "GB"
            case .spanish: return "ES"
            case .german: return "DE"
            }
        }
    }
    
    enum Theme: String, Codable, CaseIterable {
        case light = "light"
        case dark = "dark"
        case auto = "auto"
        
        var displayName: String {
            switch self {
            case .light: return "Светлая"
            case .dark: return "Темная"
            case .auto: return "Авто"
            }
        }
    }
    
    enum TextSize: String, Codable, CaseIterable {
        case small = "small"
        case medium = "medium"
        case large = "large"
        
        var displayName: String {
            switch self {
            case .small: return "Малый"
            case .medium: return "Средний"
            case .large: return "Крупный"
            }
        }
        
        var scale: CGFloat {
            switch self {
            case .small: return 0.9
            case .medium: return 1.0
            case .large: return 1.15
            }
        }
    }
    
    static let defaultSettings = AppSettings(
        language: .russian,
        theme: .light,
        textSize: .medium
    )
}

