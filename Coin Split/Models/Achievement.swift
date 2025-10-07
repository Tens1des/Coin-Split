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
        Achievement(id: "first_split", title: LocalizationKeys.achievementFirstSplit.localized, description: "Сделать свой первый раздел счёта", icon: "star.fill", isUnlocked: false),
        Achievement(id: "fair_split", title: LocalizationKeys.achievementFairSplit.localized, description: "Разделить счёт поровну между 2+ людьми", icon: "equal.circle.fill", isUnlocked: false),
        Achievement(id: "mathematician", title: LocalizationKeys.achievementMathematician.localized, description: "Использовать режим деления по процентам", icon: "percent", isUnlocked: false),
        Achievement(id: "generous", title: LocalizationKeys.achievementGenerous.localized, description: "Добавить чаевые более 15%", icon: "heart.fill", isUnlocked: false),
        Achievement(id: "historian", title: LocalizationKeys.achievementHistorian.localized, description: "Сохранить первый расчёт в истории", icon: "clock.fill", isUnlocked: false),
        Achievement(id: "archivist", title: LocalizationKeys.achievementArchivist.localized, description: "Иметь в истории 10 сохранённых расчетов", icon: "folder.fill", isUnlocked: false),
        Achievement(id: "flexible", title: LocalizationKeys.achievementFlexible.localized, description: "Использовать ручной ввод сумм для участников", icon: "slider.horizontal.3", isUnlocked: false),
        Achievement(id: "precise", title: LocalizationKeys.achievementPrecise.localized, description: "Впервые применить округление суммы", icon: "bolt.fill", isUnlocked: false),
        Achievement(id: "organizer", title: LocalizationKeys.achievementOrganizer.localized, description: "Дать имя/метку своей первой группе", icon: "tag.fill", isUnlocked: false),
        Achievement(id: "visualizer", title: LocalizationKeys.achievementVisualizer.localized, description: "Впервые открыть расчёт с мини-графиком делёжки", icon: "chart.pie.fill", isUnlocked: false),
        Achievement(id: "repeater", title: LocalizationKeys.achievementRepeater.localized, description: "Открыть старый расчёт из истории и использовать его снова", icon: "arrow.clockwise", isUnlocked: false),
        Achievement(id: "financial_guru", title: LocalizationKeys.achievementFinancialGuru.localized, description: "Сделать 50 расчётов в приложении", icon: "crown.fill", isUnlocked: false),
        Achievement(id: "big_company", title: LocalizationKeys.achievementBigCompany.localized, description: "Разделить счёт между 8+ участниками", icon: "person.3.fill", isUnlocked: false),
        Achievement(id: "economist", title: LocalizationKeys.achievementEconomist.localized, description: "Сделать расчёт без чаевых", icon: "dollarsign.circle.fill", isUnlocked: false),
        Achievement(id: "quick_calc", title: LocalizationKeys.achievementQuickCalc.localized, description: "Разделить счёт между 2 участниками", icon: "timer", isUnlocked: false),
        Achievement(id: "tip_master", title: LocalizationKeys.achievementTipMaster.localized, description: "Добавить ровно 20% чаевых", icon: "gift.fill", isUnlocked: false),
        Achievement(id: "collector", title: LocalizationKeys.achievementCollector.localized, description: "Сделать 100 расчётов в приложении", icon: "trophy.fill", isUnlocked: false),
        Achievement(id: "expert", title: LocalizationKeys.achievementExpert.localized, description: "Использовать все 3 режима деления", icon: "brain.head.profile", isUnlocked: false),
        Achievement(id: "legend", title: LocalizationKeys.achievementLegend.localized, description: "Сделать 500 расчётов в приложении", icon: "flame.fill", isUnlocked: false),
        Achievement(id: "master", title: LocalizationKeys.achievementMaster.localized, description: "Сделать 1000 расчётов в приложении", icon: "diamond.fill", isUnlocked: false)
    ]
}

