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
        
        let selectType: SelectType
        
        @ObservedObject var model: DateModel
        
        @State private var firstDateComponents: DateComponents?
        @State private var lastDateComponents: DateComponents?
        @State private var oldSelectedDateComponents: DateComponents?
        
        var body: some View {
            VStack {
                
                let rangeBinding = Binding<Set<DateComponents>>(
                    get: { model.selectedDates },
                    set: { newValue in bindingAction(with: selectType, newValue: newValue) }
                )

                MultiDatePicker(model.title, selection: rangeBinding)
                        .background(.clear)
            }
            .padding()
        }
    }
}

private extension WWSwiftUI.MultiDatePicker.MultiDatePickerView {
    
    func bindingAction(with type: WWSwiftUI.MultiDatePicker.SelectType, newValue: Set<DateComponents>) {
        
        let oldValue = model.selectedDates
        
        switch selectType {
        case .multiple: model.selectedDates = newValue
        case .single: singleBindingAction(oldValue: oldValue, newValue: newValue)
        case .range: rangeBindingAction(oldValue: oldValue, newValue: newValue)
        }
    }
    
    func singleBindingAction(oldValue: Set<DateComponents>, newValue: Set<DateComponents>) {
        
        let oldValue = model.selectedDates
        let added = newValue.subtracting(oldValue).first
        
        model.selectedDates.removeAll()
        if let added = added { model.selectedDates.insert(added) }
    }
    
    func rangeBindingAction(oldValue: Set<DateComponents>, newValue: Set<DateComponents>) {
                    
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
}
