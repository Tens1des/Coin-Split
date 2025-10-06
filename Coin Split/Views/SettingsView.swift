//
//  SettingsView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var dataManager = DataManager.shared
    @ObservedObject var localizationManager = LocalizationManager.shared
    @State private var showingClearHistoryAlert = false
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    headerView
                    personalizationSection
                    dangerZoneSection
                    Spacer(minLength: 100)
                }
                .padding(.bottom, 20)
            }
        }
        .alert(LocalizationKeys.clearHistoryAlertTitle.localized, isPresented: $showingClearHistoryAlert) {
            Button(LocalizationKeys.cancel.localized, role: .cancel) { }
            Button(LocalizationKeys.clear.localized, role: .destructive) {
                dataManager.deleteAllSplits()
            }
        } message: {
            Text(LocalizationKeys.clearHistoryAlertMessage.localized)
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        Text(LocalizationKeys.settingsTitle.localized)
            .font(.dynamicTitle())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 10)
    }
    
    // MARK: - Personalization Section
    private var personalizationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(LocalizationKeys.personalization.localized)
                .font(.dynamicSmall())
                .foregroundColor(.adaptiveSecondaryText)
                .padding(.horizontal)
            
            languageSection
            themeSection
            textSizeSection
        }
    }
    
    // MARK: - Language Section
    private var languageSection: some View {
        VStack(spacing: 12) {
            languageHeader
            languageOptions
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    private var languageHeader: some View {
        HStack(spacing: 12) {
            Image(systemName: "globe")
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 32, height: 32)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizationKeys.language.localized)
                    .font(.dynamicBody(.medium))
                Text(LocalizationKeys.languageSubtitle.localized)
                    .font(.dynamicSmall())
                    .foregroundColor(.adaptiveSecondaryText)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(12)
    }
    
    private var languageOptions: some View {
        VStack(spacing: 8) {
            ForEach(AppSettings.Language.allCases, id: \.self) { language in
                LanguageOptionView(
                    language: language,
                    isSelected: dataManager.settings.language == language,
                    onTap: {
                        var newSettings = dataManager.settings
                        newSettings.language = language
                        dataManager.updateSettings(newSettings)
                    }
                )
            }
        }
        .padding()
        .background(Color.adaptiveCardBackground.opacity(0.5))
        .cornerRadius(12)
    }
    
    // MARK: - Theme Section
    private var themeSection: some View {
        VStack(spacing: 12) {
            themeHeader
            themeOptions
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    private var themeHeader: some View {
        HStack(spacing: 12) {
            Image(systemName: "paintbrush.fill")
                .font(.system(size: 20))
                .foregroundColor(.purple)
                .frame(width: 32, height: 32)
                .background(Color.purple.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizationKeys.theme.localized)
                    .font(.dynamicBody(.medium))
                Text(LocalizationKeys.themeSubtitle.localized)
                    .font(.dynamicSmall())
                    .foregroundColor(.adaptiveSecondaryText)
            }
            
            Spacer()
        }
    }
    
    private var themeOptions: some View {
        HStack(spacing: 12) {
            ForEach(AppSettings.Theme.allCases, id: \.self) { theme in
                ThemeOptionView(
                    theme: theme,
                    isSelected: dataManager.settings.theme == theme,
                    onTap: {
                        var newSettings = dataManager.settings
                        newSettings.theme = theme
                        dataManager.updateSettings(newSettings)
                    }
                )
            }
        }
    }
    
    // MARK: - Text Size Section
    private var textSizeSection: some View {
        VStack(spacing: 12) {
            textSizeHeader
            textSizeOptions
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    private var textSizeHeader: some View {
        HStack(spacing: 12) {
            Text("T")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.pink)
                .frame(width: 32, height: 32)
                .background(Color.pink.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizationKeys.textSize.localized)
                    .font(.dynamicBody(.medium))
                Text(LocalizationKeys.textSizeSubtitle.localized)
                    .font(.dynamicSmall())
                    .foregroundColor(.adaptiveSecondaryText)
            }
            
            Spacer()
        }
    }
    
    private var textSizeOptions: some View {
        HStack(spacing: 24) {
            ForEach(AppSettings.TextSize.allCases, id: \.self) { size in
                TextSizeOptionView(
                    size: size,
                    isSelected: dataManager.settings.textSize == size,
                    onTap: {
                        var newSettings = dataManager.settings
                        newSettings.textSize = size
                        dataManager.updateSettings(newSettings)
                    }
                )
            }
        }
    }
    
    
    // MARK: - Danger Zone Section
    private var dangerZoneSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .frame(width: 32, height: 32)
                    .background(Color.red.opacity(0.1))
                    .clipShape(Circle())
                
                Text(LocalizationKeys.dangerZone.localized)
                    .font(.dynamicBody(.semibold))
                
                Spacer()
            }
            
            Text(LocalizationKeys.dangerZoneSubtitle.localized)
                .font(.dynamicSmall())
                .foregroundColor(.adaptiveSecondaryText)
            
            Button(action: {
                showingClearHistoryAlert = true
            }) {
                HStack {
                    Text(LocalizationKeys.clearHistory.localized)
                        .font(.dynamicBody(.medium))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                .padding()
                .background(Color.red.opacity(0.05))
                .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

// MARK: - Language Option View

struct LanguageOptionView: View {
    let language: AppSettings.Language
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(language.flag)
                    .font(.system(size: 20))
                
                Text(language.displayName)
                    .font(.dynamicBody())
                    .foregroundColor(.adaptiveText)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.purple)
                }
            }
            .padding()
            .background(
                isSelected
                ? Color.purple.opacity(0.1)
                : Color.adaptiveCardBackground
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isSelected
                        ? Color.purple
                        : Color.clear,
                        lineWidth: 2
                    )
            )
        }
    }
}

// MARK: - Theme Option View

struct ThemeOptionView: View {
    let theme: AppSettings.Theme
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(theme.displayName)
                .font(.dynamicCaption(isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .white : .adaptiveText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? Color.purple : Color.adaptiveCardBackground.opacity(0.5))
                .cornerRadius(12)
        }
    }
}

// MARK: - Text Size Option View

struct TextSizeOptionView: View {
    let size: AppSettings.TextSize
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: onTap) {
                Text("Aa")
                    .font(.system(size: fontSize, weight: .semibold))
                    .foregroundColor(isSelected ? .purple : .secondary)
                    .frame(width: 60, height: 60)
                    .background(
                        isSelected
                        ? Color.purple.opacity(0.1)
                        : Color.white.opacity(0.5)
                    )
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                isSelected
                                ? Color.purple
                                : Color.clear,
                                lineWidth: 2
                            )
                    )
            }
            
            Text(size.displayName)
                .font(.dynamicSmall())
                .foregroundColor(.adaptiveSecondaryText)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var fontSize: CGFloat {
        switch size {
        case .small: return 16
        case .medium: return 20
        case .large: return 24
        }
    }
}

// MARK: - Settings Row

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)
                    .frame(width: 32, height: 32)
                    .background(iconColor.opacity(0.1))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(12)
        }
    }
}

#Preview {
    SettingsView()
}

