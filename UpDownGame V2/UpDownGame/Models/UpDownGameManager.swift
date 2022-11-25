//
//  UpDownGameManager.swift
//  UpDownGame
//
//  Created by JinSeok Yang on 2022/10/01.
//

import UIKit

struct UpDownGameManager {
    
    private var randomNumber = Int.random(in: 0...30)
    private var sliderVlaue = 0
    private var win = 0
    private var lose = 0
    private var tryCount = 0
    

    mutating func sliderVlaue(value: Int) {
        
        sliderVlaue = value
    }

    mutating func winLoseCount() {
        
        if randomNumber == sliderVlaue {
            win += 1
        } else if tryCount >= 5 {
            lose += 1
        } else {
            win = 0
            lose = 0
        }
        
    }
    
    
    
    func reset() {
        
  

        
    }
    
    
    
    
}
