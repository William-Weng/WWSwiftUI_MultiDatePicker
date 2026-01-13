//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import WWSwiftUI_MultiDatePicker

final class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var multiDatePickerView: UIView!
    
    private var multiDatePicker: WWSwiftUI.MultiDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func resetAction(_ sender: UIBarButtonItem) {
        multiDatePicker.clean()
    }
    
    func initSetting() {
        multiDatePicker = WWSwiftUI.MultiDatePicker(selectType: .range)
        multiDatePicker.move(toParent: self, on: multiDatePickerView)
        multiDatePicker.delegate = self
    }
    
    deinit {
        multiDatePicker.delegate = .none
    }
}

extension ViewController: WWSwiftUI.MultiDatePicker.Delegate {
    
    func multiDatePicker(_ multiDatePicker: WWSwiftUI.MultiDatePicker, didSelected dateComponents: Set<DateComponents>) {
        let dates = !dateComponents.isEmpty ? "\(dateComponents)" : "Unselected"
        resultLabel.text = "Selected Dates: \(dates)"
    }
}
