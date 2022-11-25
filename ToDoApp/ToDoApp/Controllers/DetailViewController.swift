//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/17.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let detialView = DetailView()
    
    let toDoManager = CoreDataManager.shared
    
    var temporaryNum: Int64? = 1
    
    var toDoData: ToDoData? {
        didSet {
            temporaryNum = toDoData?.color
        }
    }
    
    override func loadView() {
        self.view = detialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configueUI()
        configureNavigationBar()
        clearButtonColors()
        configureData()
    }
    
    
}

extension DetailViewController: buttonDelegate {
    
    func colorButtonTapped(_ sender: UIButton) {
        print(#function)
        self.temporaryNum = Int64(sender.tag)
        let color = MyColor(rawValue: Int64(sender.tag))
        setupColorTheme(color: color)
        
        clearButtonColors()
        setupColorButton(num: Int64(sender.tag))
    }
    
    func updateButtonTapped(_ sender: DetailView) {
        print(#function)
        // 기존데이터가 있을때 ===> 기존 데이터 업데이트
        if let toDoData = self.toDoData {
            // 텍스트뷰에 저장되어 있는 메세지
            toDoData.memoText = sender.mainTextView.text
            toDoData.color = temporaryNum ?? 1
            toDoManager.updateToDo(newToDoData: toDoData) {
                print("업데이트 완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
            
        // 기존데이터가 없을때 ===> 새로운 데이터 생성
        } else {
            let memoText = sender.mainTextView.text
            toDoManager.saveToDoData(toDoText: memoText, colorInt: temporaryNum ?? 1) {
                print("저장완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setupColorTheme(color: MyColor? = .red) {
        detialView.mainView.backgroundColor = color?.backgroundColor
        detialView.updateButton.backgroundColor = color?.buttonColor
    }
    
    func setupColorButton(num: Int64) {
        switch num {
        case 1:
            detialView.redButton.backgroundColor = MyColor.red.buttonColor
            detialView.redButton.setTitleColor(.white, for: .normal)
        case 2:
            detialView.greenButton.backgroundColor = MyColor.green.buttonColor
            detialView.greenButton.setTitleColor(.white, for: .normal)
        case 3:
            detialView.blueButton.backgroundColor = MyColor.blue.buttonColor
            detialView.blueButton.setTitleColor(.white, for: .normal)
        case 4:
            detialView.purpleButton.backgroundColor = MyColor.purple.buttonColor
            detialView.purpleButton.setTitleColor(.white, for: .normal)
        default:
            detialView.redButton.backgroundColor = MyColor.red.buttonColor
            detialView.redButton.setTitleColor(.white, for: .normal)
        }
    }
    
    
    func configureData() {
        if let toDoData = self.toDoData {
            self.title = "메모 수정하기"
            
            guard let text = toDoData.memoText else { return }
            detialView.mainTextView.text = text
            
            detialView.mainTextView.textColor = .black
            detialView.updateButton.setTitle("UPDATE", for: .normal)
            detialView.mainTextView.becomeFirstResponder()
            let color = MyColor(rawValue: toDoData.color)
            setupColorTheme(color: color)
            
        } else {
            self.title = "새로운 메모 생성하기"
            
            detialView.mainTextView.text = "텍스트를 여기에 입력하세요."
            detialView.mainTextView.textColor = .lightGray
            detialView.updateButton.setTitle("MAKE", for: .normal)
            setupColorTheme(color: .red)
        }
        setupColorButton(num: temporaryNum ?? 1)
    }
    
    
    
    func clearButtonColors() {
        detialView.redButton.backgroundColor = MyColor.red.backgroundColor
        detialView.redButton.setTitleColor(MyColor.red.buttonColor, for: .normal)
        detialView.greenButton.backgroundColor = MyColor.green.backgroundColor
        detialView.greenButton.setTitleColor(MyColor.green.buttonColor, for: .normal)
        detialView.blueButton.backgroundColor = MyColor.blue.backgroundColor
        detialView.blueButton.setTitleColor(MyColor.blue.buttonColor, for: .normal)
        detialView.purpleButton.backgroundColor = MyColor.purple.backgroundColor
        detialView.purpleButton.setTitleColor(MyColor.purple.buttonColor, for: .normal)
    }
    
    func configueUI() {
        detialView.delegate = self
        detialView.mainTextView.delegate = self
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension DetailViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text == "" {
            print(#function)
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .darkGray
        }
    }
}
