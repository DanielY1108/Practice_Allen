//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by JinSeok Yang on 2022/09/30.
//

import UIKit


struct BMICalculatorManager {
    
    private var bmi: BMI?
    
    
    
    mutating func getBMIResult(height: String, weight: String) -> BMI {
        calBMI(height: height, weight: weight)
        return bmi ?? BMI(number: 0.0, advice: "문제발생", matchColor: .white)
    }
    
    
    mutating func calBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(number: 0.0, advice: "문제발생", matchColor: .white)
            return
        }
        
        var bmiNumber = w / (h * h) * 10000
        bmiNumber = round(bmiNumber * 10) / 10
        
        switch bmiNumber {
        case ..<18.5:
            let color = UIColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
            bmi = BMI(number: bmiNumber, advice: "저체중", matchColor: color)
            
        case 18.6...22.9:
            let color = UIColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
            bmi = BMI(number: bmiNumber, advice: "정상", matchColor: color)
            
        case 23...24.9:
            let color = UIColor(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
            bmi = BMI(number: bmiNumber, advice: "비만", matchColor: color)
            
        case 25...29.9:
            let color = UIColor(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
            bmi = BMI(number: bmiNumber, advice: "고도비만", matchColor: color)
            
        case 30...:
            let color = UIColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
            bmi = BMI(number: bmiNumber, advice: "초고도비만", matchColor: color)
            
        default:
            bmi = BMI(number: 0.0, advice: "문제발생", matchColor: .white)
        }
    }
    
    
}

