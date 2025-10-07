//
//  ProfileView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var dataManager = DataManager.shared
    @State private var showingEditProfile = false
    @State private var selectedAchievement: Achievement?
    @State private var showAllAchievements: Bool = false
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Заголовок
                    Text(LocalizationKeys.profileTitle.localized)
                        .font(.dynamicTitle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Карточка профиля
                    VStack(spacing: 20) {
                        // Аватар
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.purple, Color.blue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: dataManager.profile.avatar.isEmpty ? "person.fill" : dataManager.profile.avatar)
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.white)
                            
                            // Иконка ачивки
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.purple)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                )
                                .offset(x: 35, y: 35)
                        }
                        
                        // Имя
                        HStack(spacing: 8) {
                            Text(dataManager.profile.name)
                                .font(.system(size: 24, weight: .bold))
                            
                            Button(action: {
                                showingEditProfile = true
                            }) {
                                Image(systemName: "pencil")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        // Статистика
                        HStack(spacing: 0) {
                            StatItem(
                                value: "\(dataManager.profile.totalSplits)",
                                label: LocalizationKeys.calculations.localized,
                                color: .blue
                            )
                            
                            Divider()
                                .frame(height: 40)
                            
                            StatItem(
                                value: "\(dataManager.profile.unlockedAchievementsCount)",
                                label: LocalizationKeys.achievements.localized,
                                color: .purple
                            )
                            
                            Divider()
                                .frame(height: 40)
                            
                            StatItem(
                                value: formatAmount(dataManager.profile.totalAmount),
                                label: LocalizationKeys.profileTotal.localized,
                                color: .pink
                            )
                        }
                    }
                    .padding()
                    .background(Color.adaptiveCardBackground)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Достижения
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(LocalizationKeys.achievementsTitle.localized)
                                .font(.dynamicHeadline(.bold))
                            
                            Spacer()
                            
                            Text("\(dataManager.profile.unlockedAchievementsCount)/\(dataManager.profile.achievements.count)")
                                .font(.dynamicBody(.semibold))
                                .foregroundColor(.purple)
                        }
                        .padding(.horizontal)
                        
                        // Прогресс бар
                        ProgressView(value: Double(dataManager.profile.unlockedAchievementsCount), total: Double(dataManager.profile.achievements.count))
                            .tint(.purple)
                            .padding(.horizontal)

                        // Кнопка раскрытия/сворачивания
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                    showAllAchievements.toggle()
                                }
                            }) {
                                HStack(spacing: 6) {
                                    Text(showAllAchievements ? LocalizationKeys.achievementsShowLess.localized : LocalizationKeys.achievementsShowAll.localized)
                                        .font(.dynamicBody(.semibold))
                                    Image(systemName: showAllAchievements ? "chevron.up" : "chevron.down")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .foregroundColor(.purple)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Сетка достижений
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            let items = showAllAchievements ? dataManager.profile.achievements : Array(dataManager.profile.achievements.prefix(8))
                            ForEach(items) { achievement in
                                Button(action: {
                                    selectedAchievement = achievement
                                }) {
                                    AchievementBadge(achievement: achievement)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    
                    // Мотивационный баннер
                    VStack(spacing: 12) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.white)
                        
                        Text(LocalizationKeys.motivationTitle.localized)
                            .font(.dynamicHeadline(.bold))
                            .foregroundColor(.white)
                        
                        Text(LocalizationKeys.motivationSubtitle.localized(dataManager.profile.achievements.count - dataManager.profile.unlockedAchievementsCount))
                            .font(.dynamicCaption())
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .background(
                        LinearGradient(
                            colors: [Color.purple, Color.blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 100)
                }
                .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $showingEditProfile) {
            EditProfileSheet(profile: dataManager.profile) { newProfile in
                dataManager.updateProfile(newProfile)
                showingEditProfile = false
            }
        }
        .sheet(item: $selectedAchievement) { achievement in
            AchievementDetailView(achievement: achievement)
        }
    }
    
    private func formatAmount(_ amount: Double) -> String {
        if amount >= 1000 {
            return "\(Int(amount / 1000))к ₽"
        }
        return "\(Int(amount)) ₽"
    }
}

// MARK: - Stat Item

struct StatItem: View {
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(color)
            
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Achievement Badge

struct AchievementBadge: View {
    let achievement: Achievement
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(achievement.isUnlocked ? Color.purple.opacity(0.15) : Color.gray.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: achievement.icon)
                    .font(.system(size: 24))
                    .foregroundColor(achievement.isUnlocked ? .purple : .gray.opacity(0.4))
            }
            
            Text(achievement.title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(achievement.isUnlocked ? .primary : .secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .opacity(achievement.isUnlocked ? 1 : 0.5)
    }
}

// MARK: - Edit Profile Sheet

struct EditProfileSheet: View {
    @Environment(\.dismiss) var dismiss
    let profile: UserProfile
    let onSave: (UserProfile) -> Void
    
    @State private var name: String
    @State private var selectedIcon: String
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    let avatarIcons = ["person.fill", "star.fill", "heart.fill", "bolt.fill", 
                       "flame.fill", "crown.fill", "leaf.fill", "moon.fill",
                       "sun.max.fill", "sparkles", "trophy.fill", "shield.fill"]
    
    init(profile: UserProfile, onSave: @escaping (UserProfile) -> Void) {
        self.profile = profile
        self.onSave = onSave
        _name = State(initialValue: profile.name)
        _selectedIcon = State(initialValue: profile.avatar.isEmpty ? "person.fill" : profile.avatar)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Аватар
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.purple, Color.blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: selectedIcon)
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    
                    // Сетка иконок
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Выберите иконку")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 12) {
                            ForEach(avatarIcons, id: \.self) { icon in
                                Button(action: {
                                    selectedIcon = icon
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(selectedIcon == icon ? Color.purple : Color.gray.opacity(0.2))
                                            .frame(width: 60, height: 60)
                                        
                                        Image(systemName: icon)
                                            .font(.system(size: 24, weight: .semibold))
                                            .foregroundColor(selectedIcon == icon ? .white : .gray)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizationKeys.name.localized)
                            .font(.dynamicBody(.medium))
                            .foregroundColor(.adaptiveSecondaryText)
                        
                        TextField(LocalizationKeys.namePlaceholder.localized, text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.dynamicBody())
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 50)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(LocalizationKeys.editTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(LocalizationKeys.cancel.localized) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(LocalizationKeys.save.localized) {
                        var updatedProfile = profile
                        updatedProfile.name = name.isEmpty ? "Пользователь" : name
                        updatedProfile.avatar = selectedIcon
                        onSave(updatedProfile)
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}

