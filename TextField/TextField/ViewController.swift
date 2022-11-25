//
//  ViewController.swift
//  TextField
//
//  Created by JinSeok Yang on 2022/09/26.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {  // 프로토콜 채택
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 밑의 텍스트필드의 프로토콜을 사용하기 위해선 객체를 연결 시켜줘야 한다.
        textField.delegate = self  // 텍스트필드의 대리자 = ViewController 객체를 담는다
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.gray
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        
        textField.becomeFirstResponder()
        self.dismissKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
    // 텍스트필드의 글자 내용이 (한글자 한글자) 입력되거나 지워질때 호출이 되고 (허락)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 입력되고 있는 글자가 "숫자"인 경우 입력을 허용하지 않는 논리
        if Int(string) != nil {  // (숫자로 변환이 된다면 nil이 아닐테니)
            return false
        } else {
            // 10글자이상 입력되는 것을 막는 코드
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
}

