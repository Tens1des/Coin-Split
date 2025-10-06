//
//  TextSizeManager.swift
//  Coin Split
//
//  Created by Рома Котов on 06.10.2025.
//

import SwiftUI
import Combine

class TextSizeManager: ObservableObject {
    static let shared = TextSizeManager()
    
    @Published var currentTextSize: AppSettings.TextSize = .medium
    @Published var textScale: CGFloat = 1.0
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        setupTextSizeObserver()
    }
    
    private func setupTextSizeObserver() {
        $currentTextSize
            .sink { [weak self] textSize in
                self?.updateTextScale(for: textSize)
            }
            .store(in: &cancellables)
    }
    
    func setTextSize(_ textSize: AppSettings.TextSize) {
        currentTextSize = textSize
        UserDefaults.standard.set(textSize.rawValue, forKey: "selected_text_size")
    }
    
    private func updateTextScale(for textSize: AppSettings.TextSize) {
        textScale = textSize.scale
    }
    
    func loadSavedTextSize() {
        if let savedTextSize = UserDefaults.standard.string(forKey: "selected_text_size"),
           let textSize = AppSettings.TextSize(rawValue: savedTextSize) {
            setTextSize(textSize)
        }
    }
}

// MARK: - Font Extensions for Dynamic Text Size

extension Font {
    static func dynamicSize(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let textSizeManager = TextSizeManager.shared
        let scaledSize = size * textSizeManager.textScale
        return .system(size: scaledSize, weight: weight)
    }
    
    static func dynamicTitle(_ weight: Font.Weight = .bold) -> Font {
        return dynamicSize(34, weight: weight)
    }
    
    static func dynamicHeadline(_ weight: Font.Weight = .semibold) -> Font {
        return dynamicSize(20, weight: weight)
    }
    
    static func dynamicBody(_ weight: Font.Weight = .regular) -> Font {
        return dynamicSize(16, weight: weight)
    }
    
    static func dynamicCaption(_ weight: Font.Weight = .regular) -> Font {
        return dynamicSize(14, weight: weight)
    }
    
    static func dynamicSmall(_ weight: Font.Weight = .regular) -> Font {
        return dynamicSize(12, weight: weight)
    }
    
    static func dynamicLarge(_ weight: Font.Weight = .bold) -> Font {
        return dynamicSize(48, weight: weight)
    }
    
    static func dynamicExtraLarge(_ weight: Font.Weight = .bold) -> Font {
        return dynamicSize(64, weight: weight)
    }
}

// MARK: - View Extension for Dynamic Text Size

extension View {
    func dynamicTextSize() -> some View {
        // Простая реализация без сложных преобразований
        self.scaleEffect(TextSizeManager.shared.textScale)
    }
}
