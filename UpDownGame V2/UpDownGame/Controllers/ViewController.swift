//
//  ViewController.swift
//  UpDownGame
//
//  Created by JinSeok Yang on 2022/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hint: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    
    var upDownGameManager = UpDownGameManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.setThumbImage(UIImage(named: "slider_thumb"), for: .normal)
        
        reset()
    }
    
    func reset() {
        
        tryCountLabel.text = "0 / 5"
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValue.text = "15"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        
    }
   
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let integerValue = Int(sender.value)
        print(integerValue)
        
        sliderValue.text = String(integerValue)
    }
    
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        print(slider.value)
        
        
   
        

    }
    
    func winLose() {
        
        hint.text = "\(upDownGameManager.winLoseCount())th Win, \(upDownGameManager.winLoseCount())th Lose"
    }
    
    
    func showAlert(message: String) {
        //메시지 창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        //메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let againAction = UIAlertAction(title: "Again",
                                     style: .default,
                                     handler: nil)  //handler - 버튼 클릭했을 때 실행될 구문(아무일 없으면 생략 or nil)
        let resetAction = UIAlertAction(title: "Reset",
                                        style: .default) { action in
            self.reset()
        }
        
        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(againAction)
        alert.addAction(resetAction)
        //메시지 창 컨트롤러를 표시
        present(alert,
                animated: true,
                completion: nil)
    }  //alert 만들기...이해 불가
    
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        
        print("touch up reset button")
        reset()
    }
}
