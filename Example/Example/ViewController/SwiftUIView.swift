//
//  SwiftUIView.swift
//  Example
//
//  Created by William.Weng on 2026/1/12.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker

struct SwiftUIView: View {

    var body: some View {
        WWSwiftUI.MultiDatePickerView(selectType: .range, model: .init())
    }
}

#Preview {
    SwiftUIView()
}
