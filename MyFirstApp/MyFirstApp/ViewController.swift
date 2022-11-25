//
//  ViewController.swift
//  MyFirstApp
//
//  Created by JinSeok Yang on 2022/09/06.
//

import UIKit

class ViewController: UIViewController {
    
    //@IB: interface builder, Outlet: 배출구
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var myBtn: UIButton!
    
    // 앱의 화면에 들어오면 처음 실행 시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()  // viewDidLoad 재정의 할때는 항상 상위의 viewDidLoad 불러와야 한다
        
        mainLbl.backgroundColor = UIColor.yellow
        
    }


    @IBAction func btnPressed(_ sender: UIButton) { // 함수 내부에서 변수로 접근
        
        mainLbl.text = "안녕하세요"
        
        mainLbl.backgroundColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)  // #colorLiteral(
        mainLbl.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        mainLbl.textAlignment = NSTextAlignment.right
        
        myBtn.backgroundColor = UIColor.darkGray
        myBtn.setTitleColor(.orange, for: .normal)
        
    }
}

