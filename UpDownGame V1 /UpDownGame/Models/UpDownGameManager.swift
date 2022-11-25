//
//  UpDownGameManager.swift
//  UpDownGame
//
//  Created by JinSeok Yang on 2022/10/01.
//

import UIKit

struct UpDownGameManager {
    
    private var computerNum = Int.random(in: 1...10)
    private var myNum = 1
    
    mutating func setUserNum(num: Int) {
        myNum = num
    }
    
    func compareWithCom() -> String {
        
        // 컴퓨터의 숫자와 내가 선택한 숫자를 비교해서 up/down/bingo 확인 (mainLbl)
        if computerNum > myNum {
            return "UP"
        } else if computerNum < myNum {
            return "DOWN"
        } else if computerNum == myNum {
            return "🥰 BINGO 🥰"
        }
        return ""
    }
    
    
    mutating func resetNum() {
        
        computerNum = Int.random(in: 1...10)
        myNum = 1
        
    }
    
}


