//
//  AchievementDetailView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct AchievementDetailView: View {
    let achievement: Achievement
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                // Иконка ачивки
                ZStack {
                    Circle()
                        .fill(achievement.isUnlocked ? Color.purple : Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: achievement.icon)
                        .font(.system(size: 50, weight: .semibold))
                        .foregroundColor(achievement.isUnlocked ? .white : .gray)
                }
                
                VStack(spacing: 16) {
                    // Заголовок
                    Text(achievement.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    // Описание
                    Text(achievement.description)
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    // Статус
                    if achievement.isUnlocked {
                        VStack(spacing: 8) {
                            Text("Получено!")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.green)
                            
                            if let date = achievement.unlockedDate {
                                Text(formatDate(date))
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.top, 8)
                    } else {
                        Text("Не получено")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                }
                
                Spacer()
                
                // Кнопка закрытия
                Button(action: {
                    dismiss()
                }) {
                    Text("Закрыть")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .navigationTitle("Достижение")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
    }
}

#Preview {
    AchievementDetailView(achievement: Achievement.allAchievements[0])
}
