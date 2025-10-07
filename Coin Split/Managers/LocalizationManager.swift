//
//  LocalizationManager.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import Foundation
import SwiftUI

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    
    @Published var currentLanguage: AppSettings.Language = .russian
    @Published var localizationDictionary: [String: String] = [:]
    
    private init() {
        loadLocalization()
    }
    
    func setLanguage(_ language: AppSettings.Language) {
        currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: "selected_language")
        
        // Обновляем словарь локализации
        loadLocalization()
        
        // Обновляем локаль приложения
        Bundle.setLanguage(language.rawValue)
    }
    
    private func loadLocalization() {
        let languageCode = currentLanguage.rawValue
        localizationDictionary = loadLocalizationForLanguage(languageCode)
    }
    
    private func loadLocalizationForLanguage(_ languageCode: String) -> [String: String] {
        // Загружаем локализацию из файла или используем встроенные строки
        switch languageCode {
        case "ru":
            return russianLocalization
        case "en":
            return englishLocalization
        case "es":
            return spanishLocalization
        case "de":
            return germanLocalization
        default:
            return russianLocalization
        }
    }
    
    func localizedString(_ key: String, arguments: CVarArg...) -> String {
        let format = localizationDictionary[key] ?? key
        if arguments.isEmpty {
            return format
        } else {
            return String(format: format, arguments: arguments)
        }
    }
}

// MARK: - String Extension for Localization

extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(self)
    }
    
    func localized(_ arguments: CVarArg...) -> String {
        return LocalizationManager.shared.localizedString(self, arguments: arguments)
    }
}

// MARK: - Bundle Extension for Language Switching

extension Bundle {
    public static func setLanguage(_ language: String) {
        // Простая реализация без objc функций
        // В реальном приложении можно использовать более сложную логику
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Localization Keys

struct LocalizationKeys {
    // Common
    static let cancel = "common.cancel"
    static let save = "common.save"
    static let delete = "common.delete"
    static let share = "common.share"
    static let edit = "common.edit"
    static let clear = "common.clear"
    static let total = "common.total"
    static let participants = "common.participants"
    
    // Tabs
    static let calculation = "tab.calculation"
    static let history = "tab.history"
    static let profile = "tab.profile"
    static let settings = "tab.settings"
    
    // Calculator
    static let calculatorTitle = "calculator.title"
    static let calculatorSubtitle = "calculator.subtitle"
    static let billAmount = "calculator.bill_amount"
    static let calculatorParticipants = "calculator.participants"
    static let splitModeEqual = "calculator.split_mode.equal"
    static let splitModePercentage = "calculator.split_mode.percentage"
    static let splitModeManual = "calculator.split_mode.manual"
    static let tips = "calculator.tips"
    static let perPerson = "calculator.per_person"
    static let participantCount = "calculator.participant_count"
    static let bill = "calculator.bill"
    static let tipsPercentage = "calculator.tips_percentage"
    static let calculatorTotal = "calculator.total"
    static let calculatorSave = "calculator.save"
    static let groupName = "calculator.group_name"
    static let groupNamePlaceholder = "calculator.group_name_placeholder"
    static let saveTitle = "calculator.save_title"
    
    // History
    static let historyTitle = "history.title"
    static let calculationsCount = "history.calculations_count"
    static let emptyTitle = "history.empty_title"
    static let emptySubtitle = "history.empty_subtitle"
    static let clearAlertTitle = "history.clear_alert_title"
    static let clearAlertMessage = "history.clear_alert_message"
    static let deleteAlertTitle = "history.delete_alert_title"
    static let deleteAlertMessage = "history.delete_alert_message"
    
    // Profile
    static let profileTitle = "profile.title"
    static let calculations = "profile.calculations"
    static let achievements = "profile.achievements"
    static let profileTotal = "profile.total"
    static let achievementsTitle = "profile.achievements_title"
    static let motivationTitle = "profile.motivation_title"
    static let motivationSubtitle = "profile.motivation_subtitle"
    static let editTitle = "profile.edit_title"
    static let name = "profile.name"
    static let namePlaceholder = "profile.name_placeholder"
    
    // Achievements
    static let firstSplit = "achievement.first_split"
    static let firstSplitDesc = "achievement.first_split_desc"
    static let fairSplit = "achievement.fair_split"
    static let fairSplitDesc = "achievement.fair_split_desc"
    static let mathematician = "achievement.mathematician"
    static let mathematicianDesc = "achievement.mathematician_desc"
    static let generous = "achievement.generous"
    static let generousDesc = "achievement.generous_desc"
    static let historian = "achievement.historian"
    static let historianDesc = "achievement.historian_desc"
    static let archivist = "achievement.archivist"
    static let archivistDesc = "achievement.archivist_desc"
    static let flexible = "achievement.flexible"
    static let flexibleDesc = "achievement.flexible_desc"
    static let precise = "achievement.precise"
    static let preciseDesc = "achievement.precise_desc"
    
    // Settings
    static let settingsTitle = "settings.title"
    static let personalization = "settings.personalization"
    static let language = "settings.language"
    static let languageSubtitle = "settings.language_subtitle"
    static let theme = "settings.theme"
    static let themeSubtitle = "settings.theme_subtitle"
    static let textSize = "settings.text_size"
    static let textSizeSubtitle = "settings.text_size_subtitle"
    static let dangerZone = "settings.danger_zone"
    static let dangerZoneSubtitle = "settings.danger_zone_subtitle"
    static let clearHistory = "settings.clear_history"
    static let clearHistoryAlertTitle = "settings.clear_history_alert_title"
    static let clearHistoryAlertMessage = "settings.clear_history_alert_message"
    
    // Languages
    static let russian = "language.russian"
    static let english = "language.english"
    static let spanish = "language.spanish"
    static let german = "language.german"
    
    // Themes
    static let light = "theme.light"
    static let dark = "theme.dark"
    static let auto = "theme.auto"
    
    // Text Sizes
    static let small = "text_size.small"
    static let medium = "text_size.medium"
    static let large = "text_size.large"
    
    // Split Detail
    static let splitDetailParticipants = "split_detail.participants"
    static let splitDetailDetails = "split_detail.details"
    static let splitDetailBill = "split_detail.bill"
    static let splitDetailTips = "split_detail.tips"
    static let splitDetailTotal = "split_detail.total"
    static let splitDetailShare = "split_detail.share"
    static let splitDetailDelete = "split_detail.delete"
    static let splitDetailParticipantNumber = "split_detail.participant_number"
    
    // Achievements
    static let achievementFirstSplit = "achievement.first_split"
    static let achievementFairSplit = "achievement.fair_split"
    static let achievementMathematician = "achievement.mathematician"
    static let achievementGenerous = "achievement.generous"
    static let achievementHistorian = "achievement.historian"
    static let achievementArchivist = "achievement.archivist"
    static let achievementFlexible = "achievement.flexible"
    static let achievementPrecise = "achievement.precise"
    static let achievementOrganizer = "achievement.organizer"
    static let achievementVisualizer = "achievement.visualizer"
    static let achievementRepeater = "achievement.repeater"
    static let achievementFinancialGuru = "achievement.financial_guru"
    static let achievementBigCompany = "achievement.big_company"
    static let achievementEconomist = "achievement.economist"
    static let achievementQuickCalc = "achievement.quick_calc"
    static let achievementTipMaster = "achievement.tip_master"
    static let achievementCollector = "achievement.collector"
    static let achievementExpert = "achievement.expert"
    static let achievementLegend = "achievement.legend"
    static let achievementMaster = "achievement.master"
    
    // Achievements controls
    static let achievementsShowAll = "achievements.show_all"
    static let achievementsShowLess = "achievements.show_less"
}

// MARK: - Localization Dictionaries

private let russianLocalization: [String: String] = [
    // Common
    "common.cancel": "Отмена",
    "common.save": "Сохранить",
    "common.delete": "Удалить",
    "common.share": "Поделиться",
    "common.edit": "Редактировать",
    "common.clear": "Очистить",
    "common.total": "Всего",
    "common.participants": "Участники",
    
    // Tabs
    "tab.calculation": "Расчёт",
    "tab.history": "История",
    "tab.profile": "Профиль",
    "tab.settings": "Настройки",
    
    // Calculator
    "calculator.title": "Разделить счёт",
    "calculator.subtitle": "Быстрее и проще",
    "calculator.bill_amount": "Сумма счёта",
    "calculator.participants": "Участники",
    "calculator.split_mode.equal": "Поровну",
    "calculator.split_mode.percentage": "Процент",
    "calculator.split_mode.manual": "Вручную",
    "calculator.tips": "Чаевые",
    "calculator.per_person": "С каждого",
    "calculator.participant_count": "%d участника",
    "calculator.bill": "Счёт",
    "calculator.tips_percentage": "Чаевые (%d%%)",
    "calculator.total": "Итого",
    "calculator.save": "Сохранить",
    "calculator.group_name": "Название группы (опционально)",
    "calculator.group_name_placeholder": "Например: Обед с друзьями",
    "calculator.save_title": "Сохранить расчёт",
    "total": "всего",
    
    // History
    "history.title": "История",
    "history.calculations_count": "%d расчётов",
    "history.empty_title": "История пуста",
    "history.empty_subtitle": "Создайте первый расчёт",
    "history.clear_alert_title": "Очистить историю?",
    "history.clear_alert_message": "Это действие нельзя отменить",
    "history.delete_alert_title": "Удалить расчёт?",
    "history.delete_alert_message": "Все расчёты будут удалены. Это действие нельзя отменить.",
    
    // Profile
    "profile.title": "Профиль",
    "profile.calculations": "Расчётов",
    "profile.achievements": "Ачивок",
    "profile.total": "Всего",
    "profile.achievements_title": "Достижения",
    "profile.motivation_title": "Продолжайте в том же духе!",
    "profile.motivation_subtitle": "Ещё %d достижений ждут вас",
    "profile.edit_title": "Редактировать профиль",
    "profile.name": "Имя",
    "profile.name_placeholder": "Введите имя",
    
    // Settings
    "settings.title": "Настройки",
    "settings.personalization": "Персонализация приложения",
    "settings.language": "Язык интерфейса",
    "settings.language_subtitle": "Выберите язык",
    "settings.theme": "Тема оформления",
    "settings.theme_subtitle": "Светлая или тёмная",
    "settings.text_size": "Размер текста",
    "settings.text_size_subtitle": "Стандартный",
    "settings.danger_zone": "Опасная зона",
    "settings.danger_zone_subtitle": "Необратимые действия",
    "settings.clear_history": "Очистить всю историю",
    "settings.clear_history_alert_title": "Очистить всю историю?",
    "settings.clear_history_alert_message": "Все расчёты будут удалены. Это действие нельзя отменить.",
    
    // Achievements
    "achievement.first_split": "Первый шаг",
    "achievement.fair_split": "Справедливость",
    "achievement.mathematician": "Математик",
    "achievement.generous": "Щедрый",
    "achievement.historian": "Историк",
    "achievement.archivist": "Архивариус",
    "achievement.flexible": "Гибкость",
    "achievement.precise": "Точный глаз",
    "achievement.organizer": "Организатор",
    "achievement.visualizer": "Визуализация",
    "achievement.repeater": "Повторитель",
    "achievement.financial_guru": "Финансовый гуру",
    "achievement.big_company": "Большая компания",
    "achievement.economist": "Экономист",
    "achievement.quick_calc": "Быстрый расчёт",
    "achievement.tip_master": "Мастер чаевых",
    "achievement.collector": "Коллекционер",
    "achievement.expert": "Эксперт",
    "achievement.legend": "Легенда",
    "achievement.master": "Мастер",
    
    // Achievements controls
    "achievements.show_all": "Показать все",
    "achievements.show_less": "Свернуть"
]

private let englishLocalization: [String: String] = [
    // Common
    "common.cancel": "Cancel",
    "common.save": "Save",
    "common.delete": "Delete",
    "common.share": "Share",
    "common.edit": "Edit",
    "common.clear": "Clear",
    "common.total": "Total",
    "common.participants": "Participants",
    
    // Tabs
    "tab.calculation": "Calculation",
    "tab.history": "History",
    "tab.profile": "Profile",
    "tab.settings": "Settings",
    
    // Calculator
    "calculator.title": "Split Bill",
    "calculator.subtitle": "Quick and simple",
    "calculator.bill_amount": "Bill amount",
    "calculator.participants": "Participants",
    "calculator.split_mode.equal": "Equal",
    "calculator.split_mode.percentage": "Percentages",
    "calculator.split_mode.manual": "Manual",
    "calculator.tips": "Tips",
    "calculator.per_person": "Per person",
    "calculator.participant_count": "%d participants",
    "calculator.bill": "Bill",
    "calculator.tips_percentage": "Tips (%d%%)",
    "calculator.total": "Total",
    "calculator.save": "Save",
    "calculator.group_name": "Group name (optional)",
    "calculator.group_name_placeholder": "e.g. Dinner with friends",
    "calculator.save_title": "Save calculation",
    "total": "total",
    
    // History
    "history.title": "History",
    "history.calculations_count": "%d calculations",
    "history.empty_title": "History is empty",
    "history.empty_subtitle": "Create your first calculation",
    "history.clear_alert_title": "Clear history?",
    "history.clear_alert_message": "This action cannot be undone",
    "history.delete_alert_title": "Delete calculation?",
    "history.delete_alert_message": "All calculations will be deleted. This action cannot be undone.",
    
    // Profile
    "profile.title": "Profile",
    "profile.calculations": "Calculations",
    "profile.achievements": "Achievements",
    "profile.total": "Total",
    "profile.achievements_title": "Achievements",
    "profile.motivation_title": "Keep up the good work!",
    "profile.motivation_subtitle": "%d more achievements await you",
    "profile.edit_title": "Edit profile",
    "profile.name": "Name",
    "profile.name_placeholder": "Enter name",
    
    // Settings
    "settings.title": "Settings",
    "settings.personalization": "Application personalization",
    "settings.language": "Interface language",
    "settings.language_subtitle": "Choose language",
    "settings.theme": "Theme design",
    "settings.theme_subtitle": "Light or dark",
    "settings.text_size": "Text size",
    "settings.text_size_subtitle": "Standard",
    "settings.danger_zone": "Dangerous zone",
    "settings.danger_zone_subtitle": "Irreversible actions",
    "settings.clear_history": "Clear all history",
    "settings.clear_history_alert_title": "Clear all history?",
    "settings.clear_history_alert_message": "All calculations will be deleted. This action cannot be undone.",
    
    // Achievements
    "achievement.first_split": "First Step",
    "achievement.fair_split": "Fairness",
    "achievement.mathematician": "Mathematician",
    "achievement.generous": "Generous",
    "achievement.historian": "Historian",
    "achievement.archivist": "Archivist",
    "achievement.flexible": "Flexible",
    "achievement.precise": "Precise Eye",
    "achievement.organizer": "Organizer",
    "achievement.visualizer": "Visualization",
    "achievement.repeater": "Repeater",
    "achievement.financial_guru": "Financial Guru",
    "achievement.big_company": "Big Company",
    "achievement.economist": "Economist",
    "achievement.quick_calc": "Quick Calculation",
    "achievement.tip_master": "Tip Master",
    "achievement.collector": "Collector",
    "achievement.expert": "Expert",
    "achievement.legend": "Legend",
    "achievement.master": "Master",
    
    // Achievements controls
    "achievements.show_all": "Show all",
    "achievements.show_less": "Show less"
]

private let spanishLocalization: [String: String] = [
    // Common
    "common.cancel": "Cancelar",
    "common.save": "Guardar",
    "common.delete": "Eliminar",
    "common.share": "Compartir",
    "common.edit": "Editar",
    "common.clear": "Limpiar",
    "common.total": "Total",
    "common.participants": "Participantes",
    
    // Tabs
    "tab.calculation": "Cálculo",
    "tab.history": "Historial",
    "tab.profile": "Perfil",
    "tab.settings": "Configuración",
    
    // Calculator
    "calculator.title": "Dividir cuenta",
    "calculator.subtitle": "Rápido y simple",
    "calculator.bill_amount": "Cantidad de la cuenta",
    "calculator.participants": "Participantes",
    "calculator.split_mode.equal": "Igual",
    "calculator.split_mode.percentage": "Porcentajes",
    "calculator.split_mode.manual": "Manual",
    "calculator.tips": "Propinas",
    "calculator.per_person": "Por persona",
    "calculator.participant_count": "%d participantes",
    "calculator.bill": "Cuenta",
    "calculator.tips_percentage": "Propinas (%d%%)",
    "calculator.total": "Total",
    "calculator.save": "Guardar",
    "calculator.group_name": "Nombre del grupo (opcional)",
    "calculator.group_name_placeholder": "ej. Cena con amigos",
    "calculator.save_title": "Guardar cálculo",
    "total": "total",
    
    // History
    "history.title": "Historial",
    "history.calculations_count": "%d cálculos",
    "history.empty_title": "El historial está vacío",
    "history.empty_subtitle": "Crea tu primer cálculo",
    "history.clear_alert_title": "¿Limpiar historial?",
    "history.clear_alert_message": "Esta acción no se puede deshacer",
    "history.delete_alert_title": "¿Eliminar cálculo?",
    "history.delete_alert_message": "Todos los cálculos serán eliminados. Esta acción no se puede deshacer.",
    
    // Profile
    "profile.title": "Perfil",
    "profile.calculations": "Cálculos",
    "profile.achievements": "Logros",
    "profile.total": "Total",
    "profile.achievements_title": "Logros",
    "profile.motivation_title": "¡Sigue así!",
    "profile.motivation_subtitle": "Te esperan %d logros más",
    "profile.edit_title": "Editar perfil",
    "profile.name": "Nombre",
    "profile.name_placeholder": "Ingresa nombre",
    
    // Settings
    "settings.title": "Configuración",
    "settings.personalization": "Personalización de la aplicación",
    "settings.language": "Idioma de interfaz",
    "settings.language_subtitle": "Elige idioma",
    "settings.theme": "Diseño de tema",
    "settings.theme_subtitle": "Claro u oscuro",
    "settings.text_size": "Tamaño de texto",
    "settings.text_size_subtitle": "Estándar",
    "settings.danger_zone": "Zona peligrosa",
    "settings.danger_zone_subtitle": "Acciones irreversibles",
    "settings.clear_history": "Limpiar todo el historial",
    "settings.clear_history_alert_title": "¿Limpiar todo el historial?",
    "settings.clear_history_alert_message": "Todos los cálculos serán eliminados. Esta acción no se puede deshacer.",
    
    // Achievements
    "achievement.first_split": "Primer Paso",
    "achievement.fair_split": "Justicia",
    "achievement.mathematician": "Matemático",
    "achievement.generous": "Generoso",
    "achievement.historian": "Historiador",
    "achievement.archivist": "Archivista",
    "achievement.flexible": "Flexible",
    "achievement.precise": "Ojo Preciso",
    "achievement.organizer": "Organizador",
    "achievement.visualizer": "Visualización",
    "achievement.repeater": "Repetidor",
    "achievement.financial_guru": "Gurú Financiero",
    "achievement.big_company": "Gran Compañía",
    "achievement.economist": "Economista",
    "achievement.quick_calc": "Cálculo Rápido",
    "achievement.tip_master": "Maestro de Propinas",
    "achievement.collector": "Coleccionista",
    "achievement.expert": "Experto",
    "achievement.legend": "Leyenda",
    "achievement.master": "Maestro",
    
    // Achievements controls
    "achievements.show_all": "Mostrar todo",
    "achievements.show_less": "Mostrar menos"
]

private let germanLocalization: [String: String] = [
    // Common
    "common.cancel": "Abbrechen",
    "common.save": "Speichern",
    "common.delete": "Löschen",
    "common.share": "Teilen",
    "common.edit": "Bearbeiten",
    "common.clear": "Löschen",
    "common.total": "Gesamt",
    "common.participants": "Teilnehmer",
    
    // Tabs
    "tab.calculation": "Berechnung",
    "tab.history": "Verlauf",
    "tab.profile": "Profil",
    "tab.settings": "Einstellungen",
    
    // Calculator
    "calculator.title": "Rechnung teilen",
    "calculator.subtitle": "Schnell und einfach",
    "calculator.bill_amount": "Rechnungsbetrag",
    "calculator.participants": "Teilnehmer",
    "calculator.split_mode.equal": "Gleich",
    "calculator.split_mode.percentage": "Prozente",
    "calculator.split_mode.manual": "Manuell",
    "calculator.tips": "Trinkgeld",
    "calculator.per_person": "Pro Person",
    "calculator.participant_count": "%d Teilnehmer",
    "calculator.bill": "Rechnung",
    "calculator.tips_percentage": "Trinkgeld (%d%%)",
    "calculator.total": "Gesamt",
    "calculator.save": "Speichern",
    "calculator.group_name": "Gruppenname (optional)",
    "calculator.group_name_placeholder": "z.B. Abendessen mit Freunden",
    "calculator.save_title": "Berechnung speichern",
    "total": "gesamt",
    
    // History
    "history.title": "Verlauf",
    "history.calculations_count": "%d Berechnungen",
    "history.empty_title": "Verlauf ist leer",
    "history.empty_subtitle": "Erstelle deine erste Berechnung",
    "history.clear_alert_title": "Verlauf löschen?",
    "history.clear_alert_message": "Diese Aktion kann nicht rückgängig gemacht werden",
    "history.delete_alert_title": "Berechnung löschen?",
    "history.delete_alert_message": "Alle Berechnungen werden gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.",
    
    // Profile
    "profile.title": "Profil",
    "profile.calculations": "Berechnungen",
    "profile.achievements": "Erfolge",
    "profile.total": "Gesamt",
    "profile.achievements_title": "Erfolge",
    "profile.motivation_title": "Mach weiter so!",
    "profile.motivation_subtitle": "%d weitere Erfolge warten auf dich",
    "profile.edit_title": "Profil bearbeiten",
    "profile.name": "Name",
    "profile.name_placeholder": "Name eingeben",
    
    // Settings
    "settings.title": "Einstellungen",
    "settings.personalization": "Anwendungspersonalisierung",
    "settings.language": "Oberflächensprache",
    "settings.language_subtitle": "Sprache wählen",
    "settings.theme": "Themendesign",
    "settings.theme_subtitle": "Hell oder dunkel",
    "settings.text_size": "Textgröße",
    "settings.text_size_subtitle": "Standard",
    "settings.danger_zone": "Gefahrenzone",
    "settings.danger_zone_subtitle": "Unwiderrufliche Aktionen",
    "settings.clear_history": "Gesamten Verlauf löschen",
    "settings.clear_history_alert_title": "Gesamten Verlauf löschen?",
    "settings.clear_history_alert_message": "Alle Berechnungen werden gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.",
    
    // Achievements
    "achievement.first_split": "Erster Schritt",
    "achievement.fair_split": "Gerechtigkeit",
    "achievement.mathematician": "Mathematiker",
    "achievement.generous": "Großzügig",
    "achievement.historian": "Historiker",
    "achievement.archivist": "Archivar",
    "achievement.flexible": "Flexibel",
    "achievement.precise": "Präzises Auge",
    "achievement.organizer": "Organisator",
    "achievement.visualizer": "Visualisierung",
    "achievement.repeater": "Wiederholer",
    "achievement.financial_guru": "Finanz-Guru",
    "achievement.big_company": "Große Gesellschaft",
    "achievement.economist": "Ökonom",
    "achievement.quick_calc": "Schnelle Berechnung",
    "achievement.tip_master": "Trinkgeld-Meister",
    "achievement.collector": "Sammler",
    "achievement.expert": "Experte",
    "achievement.legend": "Legende",
    "achievement.master": "Meister",
    
    // Achievements controls
    "achievements.show_all": "Alle anzeigen",
    "achievements.show_less": "Weniger anzeigen"
]
