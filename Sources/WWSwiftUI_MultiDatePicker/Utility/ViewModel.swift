//
//  ViewModel.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import SwiftUI

// MARK: - 共享狀態模型
extension WWSwiftUI.MultiDatePicker {
    
    class DateModel: ObservableObject {
        @Published var title = "Select Dates"
        @Published var selectedDates: Set<DateComponents> = []
    }
}
