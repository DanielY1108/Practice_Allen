//
//  ViewController.swift
//  BMI
//
//  Created by JinSeok Yang on 2022/09/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var bmiButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    
    var bmiManager = BMICalculatorManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
        
    }
    
    
    func setup() {
        
        view.backgroundColor = .lightGray
        
        bmiButton.backgroundColor = .blue
        bmiButton.setTitle("BMI 계산하기", for: .normal)
        bmiButton.setTitleColor(.white, for: .normal)
        bmiButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        bmiButton.layer.cornerRadius = 5
        bmiButton.clipsToBounds = true
        
        
        heightTextField.backgroundColor = .white
        weightTextField.backgroundColor = .white
        
        weightTextField.keyboardType = UIKeyboardType.numbersAndPunctuation  // 키보드 타입
        weightTextField.placeholder = "몸무게를 입력하시오"
        weightTextField.clearButtonMode = .always
        
        heightTextField.keyboardType = UIKeyboardType.numbersAndPunctuation  // 키보드 타입
        heightTextField.placeholder = "키를 입력하시오"
        heightTextField.clearButtonMode = .always                   // 입력내용 한번에 지우는 x버튼(오른쪽)
        heightTextField.becomeFirstResponder()
        
        weightTextField.delegate = self
        heightTextField.delegate = self
    }
    
    
    @IBAction func calculateButton(_ sender: UIButton) {
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!!"
            mainLabel.textColor = .red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        mainLabel.textColor = .black
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "secondVC" {
            
            let secondVC = segue.destination as! SecondViewController
            
            guard let height = heightTextField.text,
                  let weight = weightTextField.text else { return }
            
            secondVC.bmi = bmiManager.getBMIResult(height: height, weight: weight)
            
        }
        
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    
    
}

// MARK: - extension textfield

extension ViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        
        guard Int(string) != nil || string == "" else { return false }
        guard textField.text!.count < 3 else { return false }
        
        return true
    }
    
    // MARK: - if tapped next button
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            heightTextField.resignFirstResponder()
            return true
            // 두번째 텍스트필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        } else if weightTextField.text != "" {
            heightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    
    // MARK: - dismiss keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
