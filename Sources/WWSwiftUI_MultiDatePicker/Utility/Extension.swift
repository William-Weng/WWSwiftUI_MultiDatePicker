//
//  Extension.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit

extension UIView {
    
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
