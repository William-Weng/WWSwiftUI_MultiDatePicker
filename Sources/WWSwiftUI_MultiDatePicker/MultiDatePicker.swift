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
    
    class MultiDatePicker: WWSwiftUI.`Protocol` {
        
        public let hostingController: UIHostingController<AnyView>
        
        public var view: UIView { hostingController.view }
                
        public weak var delegate: Delegate?
        
        private let model: DateModel
        private let rootView: MultiDatePickerView
        
        private var cancellables = Set<AnyCancellable>()
        
        /// 初始化
        /// - Parameter selectType: DatePicker選擇類型
        public init(selectType: SelectType = .multiple) {
            model = DateModel()
            rootView = MultiDatePickerView(selectType: selectType, model: model)
            hostingController = .init(rootView: AnyView(rootView))
            bindModel()
        }
        
        deinit {
            deinitAction()
        }
    }
}

// MARK: - 公開函式
public extension WWSwiftUI.MultiDatePicker {
    
    /// 清除所選日期
    func clean() {
        model.removeAllDate()
        rootView.reset()
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
    
    /// 處理deinit
    func deinitAction() {
        delegate = .none
        hostingController.willMove(toParent: .none)
        hostingController.view.removeFromSuperview()
        hostingController.removeFromParent()
    }
}
