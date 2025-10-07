//
//  CalculatorView.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @State private var splitName = ""
    @State private var participantNames: [String] = []
    @ObservedObject var localizationManager = LocalizationManager.shared
    
    let participantColors: [Color] = [.purple, .blue, .pink, .orange, .green, .red, .yellow, .indigo, .teal, .mint, .cyan, .brown]
    
    var body: some View {
        ZStack {
            // Градиентный фон
            LinearGradient(
                colors: [
                    Color(red: 0.85, green: 0.85, blue: 0.95),
                    Color(red: 0.92, green: 0.88, blue: 0.98)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    headerView
                    billAmountCard
                    participantsCard
                    splitModeButtons
                    tipsCard
                    
                    if viewModel.billAmount > 0 {
                        groupNameCard
                        combinedResultCard
                        saveButton
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.bottom, 20)
            }
        }
    }
    
    // MARK: - Header
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(LocalizationKeys.calculatorTitle.localized)
                .font(.system(size: 28, weight: .bold))
            Text(LocalizationKeys.calculatorSubtitle.localized)
                .font(.system(size: 16))
                .foregroundColor(.adaptiveSecondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    // MARK: - Bill Amount Card
    private var billAmountCard: some View {
        VStack(spacing: 12) {
            Text(LocalizationKeys.billAmount.localized)
                .font(.system(size: 14))
                .foregroundColor(.adaptiveSecondaryText)
            
            TextField("0", text: $viewModel.billAmountString)
                .font(.system(size: 56, weight: .bold))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .onChange(of: viewModel.billAmountString) { _ in
                    viewModel.calculateSplit()
                }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.adaptiveCardBackground)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    // MARK: - Participants Card
    private var participantsCard: some View {
        HStack {
            Text(LocalizationKeys.calculatorParticipants.localized)
                .font(.system(size: 16, weight: .medium))
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    if viewModel.participantCount > 2 {
                        viewModel.participantCount -= 1
                        viewModel.calculateSplit()
                    }
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.adaptiveSecondaryText)
                        .frame(width: 36, height: 36)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                
                Text("\(viewModel.participantCount)")
                    .font(.system(size: 20, weight: .bold))
                    .frame(minWidth: 40)
                
                Button(action: {
                    if viewModel.participantCount < 10 {
                        viewModel.participantCount += 1
                        viewModel.calculateSplit()
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Color.purple)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    // MARK: - Split Mode Buttons
    private var splitModeButtons: some View {
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
    }
    
    // MARK: - Tips Card
    private var tipsCard: some View {
        VStack(spacing: 16) {
            HStack {
                Text(LocalizationKeys.tips.localized)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Text("\(Int(viewModel.tipPercentage))%")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.purple)
            }
            
            VStack(spacing: 12) {
                Slider(value: $viewModel.tipPercentage, in: 0...20, step: 5)
                    .accentColor(.purple)
                    .onChange(of: viewModel.tipPercentage) { _ in
                        viewModel.calculateSplit()
                    }
                
                HStack {
                    ForEach([0, 5, 10, 15, 20], id: \.self) { percent in
                        Text("\(percent)%")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Int(viewModel.tipPercentage) == percent ? .purple : .adaptiveSecondaryText)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    // MARK: - Group Name Card
    private var groupNameCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(LocalizationKeys.groupName.localized)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.adaptiveSecondaryText)
            
            TextField(LocalizationKeys.groupNamePlaceholder.localized, text: $splitName)
                .font(.system(size: 16))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    // MARK: - Combined Result Card
    private var combinedResultCard: some View {
        VStack(spacing: 20) {
            // "С каждого" секция
            VStack(spacing: 12) {
                Text(LocalizationKeys.perPerson.localized)
                    .font(.system(size: 14))
                    .foregroundColor(.adaptiveSecondaryText)
                
                Text(String(format: "%.2f", viewModel.amountPerPerson))
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.purple)
            }
            
            // Участники
            VStack(spacing: 12) {
                ForEach(0..<viewModel.participantCount, id: \.self) { index in
                    HStack(spacing: 12) {
                        // Имя участника (редактируемое)
                        TextField("Участник \(index + 1)", text: Binding(
                            get: {
                                if participantNames.indices.contains(index) && !participantNames[index].isEmpty {
                                    return participantNames[index]
                                }
                                return "Участник \(index + 1)"
                            },
                            set: { newValue in
                                while participantNames.count <= index {
                                    participantNames.append("")
                                }
                                participantNames[index] = newValue
                            }
                        ))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text(String(format: "%.2f", viewModel.amountPerPerson))
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                participantColors[index % participantColors.count],
                                participantColors[index % participantColors.count].opacity(0.8)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                }
            }
            
            // Детали (итого)
            VStack(spacing: 16) {
                HStack {
                    Text(LocalizationKeys.bill.localized)
                        .font(.system(size: 16))
                        .foregroundColor(.adaptiveSecondaryText)
                    Spacer()
                    Text(String(format: "%.2f", viewModel.billAmount))
                        .font(.system(size: 16, weight: .semibold))
                }
                
                if viewModel.tipPercentage > 0 {
                    HStack {
                        Text(LocalizationKeys.tipsPercentage.localized(Int(viewModel.tipPercentage)))
                            .font(.system(size: 16))
                            .foregroundColor(.adaptiveSecondaryText)
                        Spacer()
                        Text(String(format: "%.2f", viewModel.tipAmount))
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                
                Divider()
                
                HStack {
                    Text(LocalizationKeys.calculatorTotal.localized)
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                    Text(String(format: "%.2f", viewModel.totalAmount))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.purple)
                }
            }
        }
        .padding()
        .background(Color.adaptiveCardBackground)
        .cornerRadius(20)
        .padding(.horizontal)
        .onAppear {
            if participantNames.isEmpty {
                participantNames = Array(repeating: "", count: 10)
            }
        }
    }
    
    // MARK: - Save Button
    private var saveButton: some View {
        Button(action: {
            viewModel.saveSplit(name: splitName.isEmpty ? nil : splitName, participantNames: participantNames)
            splitName = ""
            participantNames = Array(repeating: "", count: 10)
        }) {
            HStack {
                Image(systemName: "square.and.arrow.down.fill")
                    .font(.system(size: 20))
                Text(LocalizationKeys.calculatorSave.localized)
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.purple)
            .cornerRadius(16)
        }
        .padding(.horizontal)
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
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(isSelected ? .white : .adaptiveSecondaryText)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.purple : Color.adaptiveCardBackground)
                .cornerRadius(16)
        }
    }
}

#Preview {
    CalculatorView()
}
