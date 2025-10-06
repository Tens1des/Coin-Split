//
//  Coin_SplitApp.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

@main
struct Coin_SplitApp: App {
    @StateObject private var dataManager = DataManager.shared
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var textSizeManager = TextSizeManager.shared
    @StateObject private var localizationManager = LocalizationManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
                .environmentObject(themeManager)
                .environmentObject(textSizeManager)
                .environmentObject(localizationManager)
                .preferredColorScheme(themeManager.colorScheme)
                .onAppear {
                    // Ограничение на вертикальную ориентацию
                    #if os(iOS)
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
                    }
                    #endif
                }
        }
    }
}
