//
//  MultiDatePicker.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI
import Combine

// MARK: - MultiDatePicker
public extension WWSwiftUI {
    
    class MultiDatePicker: AnyObject {
        
        public enum SelectType {
            case single
            case multiple
            case range
        }
        
        public var view: UIView { hostingController.view }
        
        public weak var delegate: Delegate?
        
        private let model: DateModel
        private let hostingController: UIHostingController<MultiDatePickerView>
        
        private var cancellables = Set<AnyCancellable>()
        
        public init(selectType: SelectType = .multiple) {
            self.model = DateModel()
            self.hostingController = .init(rootView: MultiDatePickerView(selectType: selectType, model: model))
        }
        
        deinit {
            delegate = nil
            hostingController.willMove(toParent: nil)
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
        }
    }
}

// MARK: - 公開函式
public extension WWSwiftUI.MultiDatePicker {
    
    /// [移動到UIViewController上](https://www.keaura.com/blog/a-multi-date-picker-for-swiftui)
    /// - Parameters:
    ///   - parent: UIViewController
    ///   - otherView: UIView?
    func move(toParent parent: UIViewController, on otherView: UIView? = nil) {
        
        bindModel()
        
        parent.addChild(hostingController)
        hostingController.didMove(toParent: parent)
        
        if let otherView = otherView { hostingController.view._autolayout(on: otherView) }
    }
    
    /// 清除所選日期
    func clean() {
        model.removeAllDate()
        hostingController.rootView.reset()
    }
    
    /// 更新標題
    /// - Parameter title: String
    func title(_ title: String) {
        model.title = title
    }
}

// MARK: - 小工具
private extension WWSwiftUI.MultiDatePicker {
    
    /// Model綁定
    func bindModel() {
        
        model.$selectedDates
            .receive(on: RunLoop.main)
            .sink { [unowned self] in self.delegate?.multiDatePicker(self, didSelected: $0) }
            .store(in: &cancellables)
    }
}
