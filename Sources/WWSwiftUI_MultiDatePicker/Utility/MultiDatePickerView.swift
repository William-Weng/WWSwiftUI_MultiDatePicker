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

        public var body: some View {
            VStack {
                MultiDatePicker(model.title, selection: $model.selectedDates).background(.clear)
            }
            .padding()
        }
    }
}
