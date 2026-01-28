//
//  File.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by iOS on 2026/1/28.
//

import Foundation

/// [相對差集（差集）](https://zh.wikipedia.org/zh-tw/补集)
/// - Parameters:
///   - lhs: [Value]
///   - rhs: [Value]
/// - Returns: [Value]
func - <Value: Hashable>(lhs: Set<Value>, rhs: Set<Value>) -> Set<Value> {
    return lhs.subtracting(rhs)
}

// MARK: - DateComponents
extension DateComponents: Comparable {
    
    /// DateComponents比大小
    /// - Parameters:
    ///   - lhs: DateComponents
    ///   - rhs: DateComponents
    /// - Returns: Bool
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        
        guard let lhsDate = Calendar.current.date(from: lhs),
              let rhsDate = Calendar.current.date(from: rhs)
        else {
            return false
        }
        
        return lhsDate < rhsDate
    }
}
