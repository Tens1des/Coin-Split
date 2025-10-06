//
//  CalculatorView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @State private var showingNameInput = false
    @State private var splitName = ""
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Заголовок
                    Text(LocalizationKeys.calculatorTitle.localized)
                        .font(.dynamicTitle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Карточка ввода суммы
                    VStack(spacing: 16) {
                        HStack {
                            Text(LocalizationKeys.billAmount.localized)
                                .font(.dynamicBody(.medium))
                                .foregroundColor(.adaptiveSecondaryText)
                            Spacer()
                        }
                        
                        HStack(spacing: 8) {
                            TextField("0", text: $viewModel.billAmountString)
                                .font(.system(size: 48, weight: .bold))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.leading)
                                .onChange(of: viewModel.billAmountString) { _ in
                                    viewModel.calculateSplit()
                                }
                            
                            Text("₽")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Участники
                    VStack(spacing: 12) {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(.purple)
                            Text(LocalizationKeys.calculatorParticipants.localized)
                                .font(.dynamicBody(.medium))
                            Spacer()
                            
                            // +/- кнопки
                            HStack(spacing: 12) {
                                Button(action: {
                                    if viewModel.participantCount > 2 {
                                        viewModel.participantCount -= 1
                                        viewModel.calculateSplit()
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .frame(width: 32, height: 32)
                                        .background(Color.gray.opacity(0.3))
                                        .clipShape(Circle())
                                }
                                
                                Text("\(viewModel.participantCount)")
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(width: 40)
                                
                                Button(action: {
                                    viewModel.participantCount += 1
                                    viewModel.calculateSplit()
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .frame(width: 32, height: 32)
                                        .background(Color.purple)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Режимы деления
                    HStack(spacing: 12) {
                        SplitModeButton(
                            title: LocalizationKeys.splitModeEqual.localized,
                            isSelected: viewModel.splitMode == .equal,
                            action: {
                                viewModel.splitMode = .equal
                                viewModel.calculateSplit()
                            }
                        )
                        
                        SplitModeButton(
                            title: LocalizationKeys.splitModePercentage.localized,
                            isSelected: viewModel.splitMode == .percentage,
                            action: {
                                viewModel.splitMode = .percentage
                                viewModel.calculateSplit()
                            }
                        )
                        
                        SplitModeButton(
                            title: LocalizationKeys.splitModeManual.localized,
                            isSelected: viewModel.splitMode == .manual,
                            action: {
                                viewModel.splitMode = .manual
                                viewModel.calculateSplit()
                            }
                        )
                    }
                    .padding(.horizontal)
                    
                    // Чаевые
                    VStack(spacing: 12) {
                        HStack {
                            Text(LocalizationKeys.tips.localized)
                                .font(.dynamicBody(.medium))
                            Spacer()
                            Text("\(Int(viewModel.tipPercentage))%")
                                .font(.dynamicHeadline(.bold))
                                .foregroundColor(.purple)
                        }
                        
                        HStack(spacing: 8) {
                            Text("0%")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                            
                            Slider(value: $viewModel.tipPercentage, in: 0...25, step: 5)
                                .accentColor(.purple)
                                .onChange(of: viewModel.tipPercentage) { _ in
                                    viewModel.calculateSplit()
                                }
                            
                            Text("25%")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Результат
                    if viewModel.billAmount > 0 {
                        VStack(spacing: 16) {
                            Text(LocalizationKeys.perPerson.localized)
                                .font(.dynamicBody())
                                .foregroundColor(.adaptiveSecondaryText)
                            
                            Text("\(Int(viewModel.amountPerPerson))")
                                .font(.system(size: 64, weight: .bold))
                                .foregroundColor(.purple)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "person.2.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.purple.opacity(0.7))
                                Text(LocalizationKeys.participantCount.localized(viewModel.participantCount))
                                    .font(.dynamicCaption())
                                    .foregroundColor(.purple.opacity(0.7))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        // Детали
                        VStack(spacing: 12) {
                            HStack {
                                Text(LocalizationKeys.bill.localized)
                                    .foregroundColor(.adaptiveSecondaryText)
                                Spacer()
                                Text("\(Int(viewModel.billAmount))")
                                    .font(.dynamicBody(.medium))
                            }
                            
                            if viewModel.tipPercentage > 0 {
                                HStack {
                                    Text(LocalizationKeys.tipsPercentage.localized(Int(viewModel.tipPercentage)))
                                        .foregroundColor(.adaptiveSecondaryText)
                                    Spacer()
                                    Text("\(Int(viewModel.tipAmount))")
                                        .font(.dynamicBody(.medium))
                                }
                            }
                            
                            Divider()
                            
                            HStack {
                                Text(LocalizationKeys.calculatorTotal.localized)
                                    .font(.dynamicHeadline(.bold))
                                Spacer()
                                Text("\(Int(viewModel.totalAmount))")
                                    .font(.dynamicHeadline(.bold))
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        // Кнопка сохранить
                        Button(action: {
                            showingNameInput = true
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.down.fill")
                                Text(LocalizationKeys.calculatorSave.localized)
                                    .font(.dynamicHeadline(.semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $showingNameInput) {
            SaveSplitSheet(
                splitName: $splitName,
                onSave: {
                    viewModel.saveSplit(name: splitName.isEmpty ? "Безымянный расчёт" : splitName)
                    splitName = ""
                    showingNameInput = false
                },
                onCancel: {
                    showingNameInput = false
                }
            )
        }
    }
}

// MARK: - Split Mode Button

struct SplitModeButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? Color.purple : Color.white)
                .cornerRadius(12)
        }
    }
}

// MARK: - Save Split Sheet

struct SaveSplitSheet: View {
    @Binding var splitName: String
    let onSave: () -> Void
    let onCancel: () -> Void
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(LocalizationKeys.groupName.localized)
                    .font(.dynamicBody(.medium))
                    .foregroundColor(.adaptiveSecondaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField(LocalizationKeys.groupNamePlaceholder.localized, text: $splitName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.dynamicBody())
                
                Spacer()
            }
            .padding()
            .navigationTitle(LocalizationKeys.saveTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(LocalizationKeys.cancel.localized) {
                        onCancel()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(LocalizationKeys.save.localized) {
                        onSave()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    CalculatorView()
}

