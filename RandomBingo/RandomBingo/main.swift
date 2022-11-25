//
//  main.swift
//  RandomBingo
//
//  Created by JinSeok Yang on 2022/09/06.
//

import Foundation

var computerChoice = Int.random(in: 1...100)

var myChoice: Int = 0


while true {
    
    var userInput = readLine()  // debug area에 입력한 값을 받아옴
    
    
    if let input = userInput {
        if let number = Int(input) {
            
            myChoice = number
        }
    }
    
    //print(myChoice)
    
    if computerChoice > myChoice {
        print("up")
    } else if computerChoice < myChoice {
        print("down")
    } else {
        print("bingo")
        break
    }
    
}
