//
//  MyColor.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/18.
//

import UIKit

enum MyColor: Int64 {
    case red = 1
    case green, blue, purple
    // 연한색, 계산속성
    var backgroundColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 0.95, green: 0.65, blue: 0.65, alpha: 1.00)
        case .green:
            return UIColor(red: 0.68, green: 0.88, blue: 0.64, alpha: 1.00)
        case .blue:
            return UIColor(red: 0.61, green: 0.77, blue: 0.99, alpha: 1.00)
        case .purple:
            return UIColor(red: 0.79, green: 0.72, blue: 0.88, alpha: 1.00)
        }
    }
    // 진한색
    var buttonColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 0.94, green: 0.51, blue: 0.51, alpha: 1.00)
        case .green:
            return UIColor(red: 0.57, green: 0.74, blue: 0.42, alpha: 1.00)
        case .blue:
            return UIColor(red: 0.45, green: 0.67, blue: 0.99, alpha: 1.00)
        case .purple:
            return UIColor(red: 0.68, green: 0.58, blue: 0.82, alpha: 1.00)
        }
    }
}

