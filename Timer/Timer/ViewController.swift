//
//  ViewController.swift
//  Timer
//
//  Created by JinSeok Yang on 2022/09/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {  // 깔끔하게
        mainLbl.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        number = Int(sender.value * 60)  // slider.value == sender.value
        mainLbl.text = "\(number)초"
        
        
    }
    
    @IBAction func startBtnTapped(_ sender: UIButton) {
        // 1초씩 흐르게
        timer?.invalidate()
        
//        timer = Timer.scheduledTimer(timeInterval: 1,
//                                     target: self,
//                                     selector: #selector(doSomethingAfter1s),  // 함수를 실행
//                                     userInfo: nil,
//                                     repeats: true)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in

            if number > 0 {
                number -= 1
                slider.value = Float(number) / Float(60)
                mainLbl.text = "\(number) 초"

            } else {
                number = 0
                mainLbl.text = "완료!"
                timer?.invalidate()
                // 소리 나게 함
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }
    
//    @objc func doSomethingAfter1s() {
//
//        if number > 0 {
//            number -= 1
//            slider.value = Float(number) / Float(60)
//            mainLbl.text = "\(number) 초"
//
//        } else {
//            number = 0
//            mainLbl.text = "완료!"
//            timer?.invalidate()
//            // 소리 나게 함
//            AudioServicesPlayAlertSound(SystemSoundID(1322))
//        }
//
//    }
    
    
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        configureUI()
        number = 0
        timer?.invalidate()
    }
    
}

