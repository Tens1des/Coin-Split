//
//  Achievement.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation

struct Achievement: Identifiable, Codable {
    var id: String
    var title: String
    var description: String
    var icon: String
    var isUnlocked: Bool
    var unlockedDate: Date?
    
    static let allAchievements: [Achievement] = [
        Achievement(id: "first_split", title: "Первый шаг", description: "Сделать свой первый раздел счёта", icon: "star.fill", isUnlocked: false),
        Achievement(id: "fair_split", title: "Справедливость", description: "Разделить счёт поровну между 2+ людьми", icon: "equal.circle.fill", isUnlocked: false),
        Achievement(id: "mathematician", title: "Математик", description: "Использовать режим деления по процентам", icon: "percent", isUnlocked: false),
        Achievement(id: "generous", title: "Щедрый", description: "Добавить чаевые более 15%", icon: "heart.fill", isUnlocked: false),
        Achievement(id: "historian", title: "Историк", description: "Сохранить первый расчёт в истории", icon: "clock.fill", isUnlocked: false),
        Achievement(id: "archivist", title: "Архивариус", description: "Иметь в истории 10 сохранённых расчетов", icon: "folder.fill", isUnlocked: false),
        Achievement(id: "flexible", title: "Гибкость", description: "Использовать ручной ввод сумм для участников", icon: "slider.horizontal.3", isUnlocked: false),
        Achievement(id: "precise", title: "Молния", description: "Впервые применить округление суммы", icon: "bolt.fill", isUnlocked: false)
    ]
}

