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
        multiDatePicker.reset()
    }
    
    func initSetting() {
        multiDatePicker = WWSwiftUI.MultiDatePicker()
        multiDatePicker.move(toParent: self, on: multiDatePickerView)
        multiDatePicker.delegate = self
    }
}

extension ViewController: WWSwiftUI.MultiDatePicker.Delegate {
    
    func multiDatePicker(_ multiDatePicker: WWSwiftUI.MultiDatePicker, didSelected dates: [String]) {
        let dates = dates.count > 0 ? dates.joined(separator: ", ") : "Unselected"
        resultLabel.text = "Selected Dates: \(dates)"
    }
}
