//
//  Protocol.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import Foundation

// MARK: - WWSwiftUI.MultiDatePicker.Delegate
public extension WWSwiftUI.MultiDatePicker {
        
    public protocol Delegate: AnyObject {
        
        /// 取得已選擇到的日期
        /// - Parameters:
        ///   - multiDatePicker: WWSwiftUI.MultiDatePicker
        ///   - dates: Set<DateComponents>
        func multiDatePicker(_ multiDatePicker: WWSwiftUI.MultiDatePicker, didSelected dates: Set<DateComponents>)
    }
}
