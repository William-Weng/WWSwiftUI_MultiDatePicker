# WWSwiftUI+MultiDatePicker
[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-16.0](https://img.shields.io/badge/iOS-16.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSwiftUI_MultiDatePicker) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Transfer SwiftUI's MultiDatePicker to UIKit.](https://developer.apple.com/documentation/swiftui/multidatepicker)
- [將SwiftUI的MultiDatePicker轉給UIKit使用。](https://www.keaura.com/blog/a-multi-date-picker-for-swiftui)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSwiftUI_MultiDatePicker.git", .upToNextMajor(from: "1.0.0"))
]
```

### 可用函式 (Function)
|函式|功能|
|-|-|
|move(toParent:on:)|移動到UIViewController上|
|reset()|清除所選日期|
|title(_:)|更新標題|

### WWSwiftUI.MultiDatePicker.Delegate
|函式|功能|
|-|-|
|multiDatePicker(_:didSelected:)|取得已選擇到的日期|

### Example
```swift
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
```
