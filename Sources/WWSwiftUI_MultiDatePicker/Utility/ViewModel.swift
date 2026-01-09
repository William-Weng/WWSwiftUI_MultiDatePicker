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
        
        private let calendar: Calendar = .current
        private let components: Set<Calendar.Component> = [.year, .month, .day, .calendar, .era]
        
        @Published var title = "Select Dates"
        @Published var selectedDates: Set<DateComponents> = []
    }
}

// MARK: - 主功能
extension WWSwiftUI.MultiDatePicker.DateModel {
    
    /// 移除全部日期
    func removeAllDate() {
        selectedDates.removeAll()
    }
    
    /// 選擇日期區間 (沒有前後之分)
    /// - Parameters:
    ///   - date1: Date
    ///   - date2: Date
    func selectDateRange(between dateComponents1: DateComponents, and dateComponents2: DateComponents) {
        
        guard let date1 = calendar.date(from: dateComponents1),
              let date2 = calendar.date(from: dateComponents2)
        else {
            return
        }
        
        selectDateRange(between: date1, and: date2)
    }
}

// MARK: - 小工具
private extension WWSwiftUI.MultiDatePicker.DateModel {
    
    /// 選擇日期區間 (沒有前後之分)
    /// - Parameters:
    ///   - date1: Date
    ///   - date2: Date
    func selectDateRange(between date1: Date, and date2: Date) {
        let dates = [date1, date2].sorted { $0 < $1 }
        selectDateRange(from: dates[0], to: dates[1])
    }
}

// MARK: - 小工具
private extension WWSwiftUI.MultiDatePicker.DateModel {

    /// 加入日期
    /// - Parameter date: Date
    func insertDate(_ date: Date) {
        let components = calendar.dateComponents(components, from: date)
        selectedDates.insert(components)
    }
    
    /// 加入今天日期
    func insertToday() {
        let today = Date()
        insertDate(today)
    }
    
    /// 移除日期
    /// - Parameter date: Date
    func removeDate(_ date: Date) {
        let someday = calendar.dateComponents(components, from: date)
        selectedDates.remove(someday)
    }
    
    /// 移除今天日期
    func removeToday() {
        let today = Date()
        removeDate(today)
    }
    
    /// 選擇日期區間 (有前後之分)
    /// - Parameters:
    ///   - startDate: Date
    ///   - endDate: Date
    func selectDateRange(from startDate: Date, to endDate: Date) {
        
        let startComponents = calendar.dateComponents(components, from: startDate)
        let endComponents = calendar.dateComponents(components, from: endDate)
        
        var currentDate = calendar.date(from: startComponents) ?? startDate
        let endDate = calendar.date(from: endComponents) ?? endDate
        
        while currentDate <= endDate {
            let components = calendar.dateComponents(components, from: currentDate)
            selectedDates.insert(components)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
    }
}
