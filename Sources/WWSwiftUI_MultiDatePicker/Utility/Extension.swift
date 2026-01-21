//
//  Extension.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI
import Charts

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

// MARK: - UIView
public extension UIView {
    
    /// [設定LayoutConstraint => 不能加frame](https://zonble.gitbooks.io/kkbox-ios-dev/content/autolayout/intrinsic_content_size.html)
    /// - Parameter superView: [此View的SuperView](https://www.appcoda.com.tw/auto-layout-programmatically/)
    func _autolayout(on superView: UIView) {
        
        removeFromSuperview()
        superView.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
        ])
    }
}

// MARK: - View
public extension View {
    
    /// 點擊View的反應
    /// - Parameter action: (ChartProxy, CGPoint) -> Void
    /// - Returns: View
    func _chartOverlayOnTap(action: @escaping (ChartProxy, CGPoint) -> Void) -> some View {
        
        chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture { location in action(proxy, location) }
            }
        }
    }
}

// MARK: - View (@ViewBuilder)
public extension View {
    
    /// 畫面的if功能
    /// - Parameters:
    ///   - condition: 判斷式
    ///   - transform: (Self) -> Content
    /// - Returns: some View
    @ViewBuilder
    func _if<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - ChartContent (@ChartContentBuilder)
public extension ChartContent {
    
    /// 圖表的if功能
    /// - Parameters:
    ///   - condition: 判斷式
    ///   - transform: (Self) -> Content
    /// - Returns: some View
    @ChartContentBuilder
    func _if<Content: ChartContent>(_ condition: Bool, transform: (Self) -> Content) -> some ChartContent {
        
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
