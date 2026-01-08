//
//  MultiDatePickerView.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import SwiftUI

// MARK: - MultiDatePicker (SwiftUI)
extension WWSwiftUI.MultiDatePicker {
    
    struct MultiDatePickerView: View {
        
        @ObservedObject var model: DateModel

        @State private var firstDateComponents: DateComponents?
        @State private var lastDateComponents: DateComponents?
        @State private var oldSelectedDateComponents: DateComponents?
        
        func setRangeBinding(oldValue: Set<DateComponents>, newValue: Set<DateComponents>) {
            
            let oldValue = model.selectedDates
            let added = newValue.subtracting(oldValue).first
            let removed = oldValue.subtracting(newValue).first
            let selectedDateComponents = added ?? removed
            
            if (oldSelectedDateComponents == selectedDateComponents) {
                model.selectedDates = []
                firstDateComponents = nil
                lastDateComponents = nil
                oldSelectedDateComponents = nil
                return
            }
            
            oldSelectedDateComponents = selectedDateComponents
            
            if let firstDateComponents {
                
                let oldFirstDateComponents = firstDateComponents
                let oldLastDateComponents = lastDateComponents
                
                if model.selectedDates.count > 2 {
                    
                    if firstDateComponents <= selectedDateComponents! {
                        self.lastDateComponents = selectedDateComponents
                    } else {
                        self.lastDateComponents = oldLastDateComponents
                        self.firstDateComponents = selectedDateComponents
                    }
                } else {
                    lastDateComponents = selectedDateComponents
                }
                
            } else {
                firstDateComponents = selectedDateComponents
            }
            
            if let first = firstDateComponents, let last = lastDateComponents {
                model.selectedDates.removeAll()
                model.selectDateRange(between: first, and: last)
                if first > last {
                    (firstDateComponents, lastDateComponents) = (lastDateComponents, firstDateComponents)
                }
                
            } else {
                model.selectedDates = newValue  // 正常同步
            }
        }
        
        var body: some View {
            VStack {
                
                let rangeBinding = Binding<Set<DateComponents>>(
                    get: { model.selectedDates },
                    set: { newValue in setRangeBinding(oldValue: model.selectedDates, newValue: newValue) }
                )

                MultiDatePicker(model.title, selection: rangeBinding)
                        .background(.clear)
            }
            .padding()
        }
    }
}
