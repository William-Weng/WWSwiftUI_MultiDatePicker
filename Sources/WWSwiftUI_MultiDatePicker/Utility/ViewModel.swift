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

extension WWSwiftUI.MultiDatePicker.DateModel {
    
    func insertDate(_ date: Date) {
        let components = calendar.dateComponents(components, from: date)
        selectedDates.insert(components)
    }
    
    func insertToday() {
        let today = Date()
        insertDate(today)
    }
    
    func removeDate(_ date: Date) {
        let someday = calendar.dateComponents(components, from: date)
        selectedDates.remove(someday)
    }
    
    func removeToday() {
        let today = Date()
        removeDate(today)
    }
    
    func removeAllDate() {
        selectedDates.removeAll()
    }
    
    func selectDateRange(between dateComponents1: DateComponents, and dateComponents2: DateComponents) {
        
        guard let date1 = calendar.date(from: dateComponents1),
              let date2 = calendar.date(from: dateComponents2)
        else {
            return
        }
        
        let dates = [date1, date2].sorted { $0 < $1 }
        selectDateRange(from: dates[0], to: dates[1])
    }
    
    func selectDateRange(between date1: Date, and date2: Date, by calendar: Calendar) {
        let dates = [date1, date2].sorted { $0 < $1 }
        selectDateRange(from: dates[0], to: dates[1])
    }
    
    func autoSelectDateRange(by calendar: Calendar) {

        let dates = Array(selectedDates).sorted()
        
        guard selectedDates.count > 1,
              let firstDate = dates.first,
              let lastDate = dates.last
        else {
            return
        }
        
        let date1 = calendar.date(from: firstDate)!
        let date2 = calendar.date(from: lastDate)!
        
        print("date1 = \(date1), date2 = \(date2)")

        selectedDates.removeAll()
        selectDateRange(from: date1, to: date2)
    }
}

extension WWSwiftUI.MultiDatePicker.DateModel {
    
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

extension DateComponents: Comparable {
    
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        guard let lhsDate = Calendar.current.date(from: lhs),
              let rhsDate = Calendar.current.date(from: rhs) else { return false }
        return lhsDate < rhsDate
    }
}
