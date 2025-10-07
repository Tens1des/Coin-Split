//
//  HistoryView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var dataManager = DataManager.shared
    @State private var showingDeleteAlert = false
    @State private var selectedSplit: Split?
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Заголовок
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(LocalizationKeys.historyTitle.localized)
                            .font(.dynamicTitle())
                        Text(LocalizationKeys.calculationsCount.localized(dataManager.splits.count))
                            .font(.dynamicBody())
                            .foregroundColor(.adaptiveSecondaryText)
                    }
                    
                    Spacer()
                    
                    // Кнопка удаления всей истории
                    if !dataManager.splits.isEmpty {
                        Button(action: {
                            showingDeleteAlert = true
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 16)
                
                if dataManager.splits.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.gray.opacity(0.3))
                        
                        Text(LocalizationKeys.emptyTitle.localized)
                            .font(.dynamicHeadline(.semibold))
                            .foregroundColor(.adaptiveSecondaryText)
                        
                        Text(LocalizationKeys.emptySubtitle.localized)
                            .font(.dynamicBody())
                            .foregroundColor(.adaptiveSecondaryText)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(dataManager.splits) { split in
                                NavigationLink(destination: SplitDetailView(split: split)) {
                                    HistoryCard(split: split)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
        .alert(LocalizationKeys.clearAlertTitle.localized, isPresented: $showingDeleteAlert) {
            Button(LocalizationKeys.cancel.localized, role: .cancel) { }
            Button(LocalizationKeys.clear.localized, role: .destructive) {
                dataManager.deleteAllSplits()
            }
        } message: {
            Text(LocalizationKeys.clearAlertMessage.localized)
        }
    }
}

// MARK: - History Card

struct HistoryCard: View {
    let split: Split
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(split.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text(formattedDate(split.date))
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "person.2")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text("\(split.participantCount)")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack(spacing: 4) {
                    Text("\(Int(split.amountPerPerson))")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("/ \(Int(split.totalAmount)) \(LocalizationKeys.total.localized)")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Text(LocalizationKeys.perPerson.localized)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.purple)
                .padding(12)
                .background(
                    Circle()
                        .stroke(Color.purple.opacity(0.3), lineWidth: 2)
                )
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(16)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationView {
        HistoryView()
    }
}

