//
//  MainTabView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalculatorView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "app.fill" : "app")
                            .font(.system(size: 22))
                        Text(LocalizationKeys.calculation.localized)
                            .font(.system(size: 10))
                    }
                }
                .tag(0)
            
            NavigationView {
                HistoryView()
            }
            .tabItem {
                VStack {
                    Image(systemName: selectedTab == 1 ? "clock.fill" : "clock")
                        .font(.system(size: 22))
                    Text(LocalizationKeys.history.localized)
                        .font(.system(size: 10))
                }
            }
            .tag(1)
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                VStack {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                        .font(.system(size: 22))
                    Text(LocalizationKeys.profile.localized)
                        .font(.system(size: 10))
                }
            }
            .tag(2)
            
            NavigationView {
                SettingsView()
            }
            .tabItem {
                VStack {
                    Image(systemName: selectedTab == 3 ? "gearshape.fill" : "gearshape")
                        .font(.system(size: 22))
                    Text(LocalizationKeys.settings.localized)
                        .font(.system(size: 10))
                }
            }
            .tag(3)
        }
        .accentColor(.purple)
    }
}

#Preview {
    MainTabView()
}

