//
//  Split.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation

struct Split: Identifiable, Codable {
    var id = UUID()
    var name: String
    var date: Date
    var totalAmount: Double
    var participants: [Participant]
    var tipPercentage: Double
    var splitMode: SplitMode
    var billAmount: Double // Счёт без чаевых
    var tipAmount: Double // Сумма чаевых
    
    enum SplitMode: String, Codable {
        case equal = "equal"
        case percentage = "percentage"
        case manual = "manual"
    }
    
    var participantCount: Int {
        participants.count
    }
    
    var amountPerPerson: Double {
        guard participantCount > 0 else { return 0 }
        return totalAmount / Double(participantCount)
    }
}
