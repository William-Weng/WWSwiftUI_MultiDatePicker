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
        
        public var view: UIView { hostingController.view }
        
        public weak var delegate: Delegate?
        
        private let model: DateModel
        private let hostingController: UIHostingController<MultiDatePickerView>
        
        private var cancellables = Set<AnyCancellable>()
        
        public init() {
            self.model = DateModel()
            self.hostingController = .init(rootView: MultiDatePickerView(model: model))
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
        
        if let otherView = otherView {
            otherView.addSubview(view)
            hostingController.view.frame = otherView.bounds
        }
    }
    
    /// 清除所選日期
    func reset() {
        model.selectedDates.removeAll()
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
            .sink { [unowned self] dateComponents in
                let dates = self.formatDates(with: dateComponents)
                self.delegate?.multiDatePicker(self, didSelected: dates ?? [])
            }
            .store(in: &cancellables)
    }
    
    /// 日期格式轉換
    /// - Parameter dateComponents: Set<DateComponents>
    /// - Returns: [String]
    func formatDates(with dateComponents: Set<DateComponents>) -> [String] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formatDates = dateComponents
                    .compactMap { Calendar.current.date(from: $0) }
                    .map { dateFormatter.string(from: $0) }
                    .sorted()
        
        return formatDates

    }
}
