//
//  Protocol.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI

// MARK: - 公用功能
public extension WWSwiftUI {
    
    public protocol `Protocol`: AnyObject {
        
        var view: UIView { get }
        var hostingController: UIHostingController<AnyView> { get }
        
        func move(toParent parent: UIViewController, on otherView: UIView?)
    }
}

// MARK: - 程式實作
public extension WWSwiftUI.`Protocol` {
    
    /// [移動到UIViewController上](https://www.keaura.com/blog/a-multi-date-picker-for-swiftui)
    /// - Parameters:
    ///   - parent: UIViewController
    ///   - otherView: UIView?
    func move(toParent parent: UIViewController, on otherView: UIView? = .none) {
        
        parent.addChild(hostingController)
        hostingController.didMove(toParent: parent)
        
        if let otherView = otherView { hostingController.view._autolayout(on: otherView) }
    }
}

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
