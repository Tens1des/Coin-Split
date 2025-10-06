//
//  CalculatorViewModel.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation
import Combine

class CalculatorViewModel: ObservableObject {
    @Published var billAmountString: String = ""
    @Published var participantCount: Int = 4
    @Published var tipPercentage: Double = 10
    @Published var splitMode: Split.SplitMode = .equal
    
    @Published var billAmount: Double = 0
    @Published var tipAmount: Double = 0
    @Published var totalAmount: Double = 0
    @Published var amountPerPerson: Double = 0
    @Published var participants: [Participant] = []
    
    func calculateSplit() {
        // Парсим сумму
        billAmount = Double(billAmountString) ?? 0
        
        // Рассчитываем чаевые
        tipAmount = billAmount * (tipPercentage / 100)
        
        // Общая сумма
        totalAmount = billAmount + tipAmount
        
        // Сумма на человека
        if participantCount > 0 {
            amountPerPerson = totalAmount / Double(participantCount)
        }
        
        // Создаём участников
        createParticipants()
    }
    
    private func createParticipants() {
        let colors: [Participant.ParticipantColor] = [.blue, .purple, .pink, .orange, .green, .red, .cyan, .yellow]
        participants = (1...participantCount).map { index in
            Participant(
                name: "Участник #\(index)",
                amount: amountPerPerson,
                percentage: 100.0 / Double(participantCount),
                color: colors[index % colors.count]
            )
        }
    }
    
    func saveSplit(name: String) {
        let split = Split(
            name: name,
            date: Date(),
            totalAmount: totalAmount,
            participants: participants,
            tipPercentage: tipPercentage,
            splitMode: splitMode,
            billAmount: billAmount,
            tipAmount: tipAmount
        )
        
        DataManager.shared.addSplit(split)
        
        // Сбрасываем поля
        resetFields()
    }
    
    private func resetFields() {
        billAmountString = ""
        participantCount = 4
        tipPercentage = 10
        splitMode = Split.SplitMode.equal
        billAmount = 0
        tipAmount = 0
        totalAmount = 0
        amountPerPerson = 0
        participants = []
    }
}

