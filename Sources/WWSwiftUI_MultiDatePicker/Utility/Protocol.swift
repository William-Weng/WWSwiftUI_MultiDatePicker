//
//  Protocol.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import Foundation

public extension WWSwiftUI.MultiDatePicker {
        
    public protocol Delegate: AnyObject {
        
        /// 取得已選擇到的日期
        func multiDatePicker(_ multiDatePicker: WWSwiftUI.MultiDatePicker, didSelected dates: Set<DateComponents>)
    }
}
