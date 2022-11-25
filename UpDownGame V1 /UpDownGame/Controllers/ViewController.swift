//
//  ViewController.swift
//  UpDownGame
//
//  Created by JinSeok Yang on 2022/09/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    
    
    var upDownGameManager = UpDownGameManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLbl.text = "선택하세요"
        numberLbl.text = ""
        

    }

    @IBAction func btnTapped(_ sender: UIButton) {
       
        guard let numString = sender.currentTitle else { return }  //sender의 자료형은 UIbutton을 클릭하면 UIbutton의 하위값이 타이틀을 뽑아 낸다.
        guard let IntNum = Int(numString) else { return }
        
        upDownGameManager.setUserNum(num: IntNum)
        numberLbl.text = numString
    }
    
    
    @IBAction func selectBtnTapped(_ sender: UIButton) {

        mainLbl.text = upDownGameManager.compareWithCom()
    
    }
    
    
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        // 메인 레이블 "선택하세요", 숫자 레이블 빈문자열
        mainLbl.text = "선택하세요"
        numberLbl.text = ""
    
        upDownGameManager.resetNum()
        
    }
}

