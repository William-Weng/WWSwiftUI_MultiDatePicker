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
        @State private var selectedDateComponents: DateComponents?
        
        var body: some View {
            VStack {
                
                let binding = Binding<Set<DateComponents>>(
                    get: { model.selectedDates },
                    set: { newValue in bindingAction(with: selectType, newValue: newValue) }
                )
                
                MultiDatePicker(model.title, selection: binding)
                        .background(.clear)
            }
            .padding()
        }
        
        /// 還原初始值
        func reset() {
            firstDateComponents = .none
            lastDateComponents = .none
            selectedDateComponents = .none
        }
    }
}

// MARK: - 主要工具
private extension WWSwiftUI.MultiDatePicker.MultiDatePickerView {
    
    /// 跟MultiDatePicker綁定數值變化的處理
    /// - Parameters:
    ///   - selectType: 使用模式 (單選 / 多選 / 範圍選)
    ///   - newValue: 更新後的數值
    func bindingAction(with selectType: WWSwiftUI.MultiDatePicker.SelectType, newValue: Set<DateComponents>) {
                
        switch selectType {
        case .multiple: multipleBindingAction(newValue: newValue)
        case .single: singleBindingAction(newValue: newValue)
        case .range: rangeBindingAction(newValue: newValue)
        }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.MultiDatePicker.MultiDatePickerView {
    
    /// 單選模式下的處理 (只留下最新的)
    /// - Parameter newValue: Set<DateComponents>
    func singleBindingAction(newValue: Set<DateComponents>) {
        
        let oldValue = model.selectedDates
        let added = newValue.subtracting(oldValue).first
        
        model.removeAllDate()
        if let added = added { model.selectedDates.insert(added) }
    }
    
    /// 多選模式下的處理 (照舊)
    /// - Parameter newValue: Set<DateComponents>
    func multipleBindingAction(newValue: Set<DateComponents>) {
        model.selectedDates = newValue
    }
    
    /// 範圍選模式下的處理 (只留下頭尾之間的)
    /// - Parameter newValue: Set<DateComponents>
    func rangeBindingAction(newValue: Set<DateComponents>) {
        
        let oldValue = model.selectedDates
        let added = newValue.subtracting(oldValue).first
        let removed = oldValue.subtracting(newValue).first
        let selected = added ?? removed
        
        if model.selectedDates.isEmpty { reset() }
        if checkDoubleClickedAction(forRangeBinding: selected) { return }
        
        selectedDateComponents = selected
        orderRangeDateComponents(first: firstDateComponents, last: lastDateComponents, selected: selected)
        if !checkDateRangeAction(first: firstDateComponents, last: lastDateComponents) { model.selectedDates = newValue }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.MultiDatePicker.MultiDatePickerView {
    
    /// 同一個日期點兩下就全部清除
    /// - Parameter dateComponents: DateComponents?
    /// - Returns: Bool
    func checkDoubleClickedAction(forRangeBinding dateComponents: DateComponents?) -> Bool {
        
        if (selectedDateComponents != dateComponents) { return false }
        
        model.removeAllDate()
        reset()
        
        return true
    }
    
    /// 處理日期範圍的頭尾順序 (有三個以上的值才需要被處理)
    /// - Parameters:
    ///   - first: 開頭日期
    ///   - last: 結尾日期
    ///   - selected: 選中的日期
    func orderRangeDateComponents(first: DateComponents?, last: DateComponents?, selected: DateComponents?) {
        
        guard let selected = selected else { return }
        guard let first = first else { firstDateComponents = selected; return }
                
        if (selected > first) { lastDateComponents = selected; return }
        
        firstDateComponents = selected
        lastDateComponents = last ?? first
    }
    
    /// 執行範圍內的日期選取
    /// - Parameters:
    ///   - first: DateComponents?
    ///   - last: DateComponents?
    /// - Returns: Bool
    func checkDateRangeAction(first: DateComponents?, last: DateComponents?) -> Bool {
        
        guard let first = first,
              let last = last
        else {
            return false
        }
        
        model.removeAllDate()
        model.selectDateRange(between: first, and: last)
        
        return true
    }
}
