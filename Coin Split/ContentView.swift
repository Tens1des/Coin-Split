//
//  ContentView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager.shared
    
    var body: some View {
        MainTabView()
            .environmentObject(dataManager)
    }
}

#Preview {
    ContentView()
}
