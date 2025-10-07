//
//  SplitDetailView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct SplitDetailView: View {
    let split: Split
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Заголовок
                    VStack(alignment: .leading, spacing: 8) {
                        Text(split.name)
                            .font(.system(size: 28, weight: .bold))
                        
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            Text(formattedDate(split.date))
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // С каждого
                    VStack(spacing: 12) {
                        Text("С каждого")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                        
                        Text("\(Int(split.amountPerPerson))")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundColor(.purple)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.purple)
                            Text("\(split.participantCount) участника")
                                .font(.system(size: 14))
                                .foregroundColor(.purple)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple.opacity(0.3), lineWidth: 1.5)
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(Color.adaptiveCardBackground)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Участники
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Участники")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(Array(split.participants.enumerated()), id: \.element.id) { index, participant in
                                HStack(spacing: 12) {
                                    // Аватар
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 44, height: 44)
                                        
                                        Text("\(index + 1)")
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(participant.color.color)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(participant.name)
                                            .font(.system(size: 16, weight: .semibold))
                                        Text("Участник #\(index + 1)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("\(Int(participant.amount))")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(participant.color.color)
                                }
                                .padding()
                                .background(participant.color.color.opacity(0.1))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                            }
                        }
                        .padding()
                        .background(Color.adaptiveCardBackground)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    // Детали
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Детали")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            HStack {
                                Text("Счёт")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(Int(split.billAmount))")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            
                            if split.tipPercentage > 0 {
                                HStack {
                                    Text("Чаевые (\(Int(split.tipPercentage))%)")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(Int(split.tipAmount))")
                                        .font(.system(size: 16, weight: .medium))
                                }
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Итого")
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                Text("\(Int(split.totalAmount))")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding()
                        .background(Color.adaptiveCardBackground)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    // Кнопка удаления
                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                            Text("Удалить")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 100)
                }
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Удалить расчёт?", isPresented: $showingDeleteAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Удалить", role: .destructive) {
                DataManager.shared.deleteSplit(split)
                dismiss()
            }
        }
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
        SplitDetailView(split: Split(
            name: "Ресторан \"Белуга\"",
            date: Date(),
            totalAmount: 4800,
            participants: [
                Participant(name: "Александр", amount: 1320, percentage: 25, color: .blue),
                Participant(name: "Мария", amount: 1320, percentage: 25, color: .purple),
                Participant(name: "Дмитрий", amount: 1320, percentage: 25, color: .pink),
                Participant(name: "Елена", amount: 1320, percentage: 25, color: .orange)
            ],
            tipPercentage: 10,
            splitMode: .equal,
            billAmount: 4320,
            tipAmount: 480
        ))
    }
}

