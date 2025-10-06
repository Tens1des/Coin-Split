//
//  Participant.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation
import SwiftUI

struct Participant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var amount: Double
    var percentage: Double
    var color: ParticipantColor
    
    enum ParticipantColor: String, Codable, CaseIterable {
        case blue = "blue"
        case purple = "purple"
        case pink = "pink"
        case orange = "orange"
        case green = "green"
        case red = "red"
        case cyan = "cyan"
        case yellow = "yellow"
        
        var color: Color {
            switch self {
            case .blue: return .blue
            case .purple: return .purple
            case .pink: return .pink
            case .orange: return .orange
            case .green: return .green
            case .red: return .red
            case .cyan: return .cyan
            case .yellow: return .yellow
            }
        }
    }
}
