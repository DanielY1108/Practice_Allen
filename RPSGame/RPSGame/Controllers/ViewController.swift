//
//  ViewController.swift
//  RPSGame
//
//  Created by JinSeok Yang on 2022/09/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLbl: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var comImageView: UIImageView!
    
    @IBOutlet weak var myChoiceLbl: UILabel!
    @IBOutlet weak var comChoiceLbl: UILabel!
    
    var rpsManager = RPSManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) 이미지 뷰의 준비 이미지를 띄운다.
        myImageView.image = rpsManager.getReadyRPS().rpsInfo.image
        comImageView.image = rpsManager.getReadyRPS().rpsInfo.image
        
        // 2) Label에 "준비"라고 문자열을 띄워야 함
        comChoiceLbl.text = rpsManager.getReadyRPS().rpsInfo.name
        myChoiceLbl.text = rpsManager.getReadyRPS().rpsInfo.name
        
        rpsManager.allReset()
        
    }


    @IBAction func RPSBtntapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle else { return }
        
        print(title)

        rpsManager.getUserSelect(name: title)
        
    }
    
    
    @IBAction func selectBtnTapped(_ sender: UIButton) {
 
        comImageView.image = rpsManager.getComRps().rpsInfo.image
        comChoiceLbl.text = rpsManager.getComRps().rpsInfo.name
        
        myImageView.image = rpsManager.getMyRps().rpsInfo.image
        myChoiceLbl.text = rpsManager.getMyRps().rpsInfo.name
        
        mainLbl.text = rpsManager.compareWithEachOther()
         
    }
    
    
    @IBAction func resetBtnTapped(_ sender: UIButton) {

        viewDidLoad()
        
        mainLbl.text = "선택하세요"
 
    }
    
}
