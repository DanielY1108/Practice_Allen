//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        
        
        let firstVC = FirstViewController()
        
        firstVC.someString = "🫠"
        
        firstVC.modalPresentationStyle = .fullScreen
        
        present(firstVC, animated: true, completion: nil)
        
        
    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController else { return }
        
        secondVC.someString = "🥰"
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: true, completion: nil)
        
        
    }
    
    
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        
        if true {
            performSegue(withIdentifier: "toThirdVC", sender: self)
        } else {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toThirdVC" {
            
            let thirdVC = segue.destination as! ThirdViewController
            thirdVC.modalPresentationStyle = .fullScreen
            thirdVC.someString = "🧐"
        }
        
        if segue.identifier == "toFourthVC" {
            
            let fourthVC = segue.destination as! FourthViewController
            
            fourthVC.someString = "😇"
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if true {
            return true
        }
    }  // 세그웨이를 실행할지 말지(조건), shouldPerformSegue는 버튼에서 직접적으로 연결했을때만 생성가능
    
    
}

