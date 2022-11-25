//
//  RPSManager.swift
//  RPSGame
//
//  Created by JinSeok Yang on 2022/10/01.
//

import UIKit

struct RPSManager {
    
    private var myChoice: Rps = Rps(rawValue: Int.random(in: 1...3))!
    private var comChoice: Rps = Rps(rawValue: Int.random(in: 1...3))!
    
    
    func getReadyRPS() -> Rps {
        return Rps.ready
    }
    
    func getComRps() -> Rps {
        return comChoice
    }
    
    func getMyRps() -> Rps {
        return myChoice
    }
    
    mutating func getUserSelect(name: String) {
        
        switch name {
        case "가위":
            myChoice =  Rps.scissors
        case "바위":
            myChoice =  Rps.rock
        case "보":
            myChoice =  Rps.paper
        default:
            myChoice = Rps.ready
        }
    }
    
    func compareWithEachOther() -> String {
        
        if comChoice == myChoice {
            return "비겼다"
        } else if comChoice == .rock && myChoice == .paper {
            return "이겼다"
        } else if comChoice == .scissors && myChoice == .rock {
            return "이겼다"
        } else if comChoice == .paper && myChoice == .scissors {
            return "이겼다"
        } else {
            return "졌다"
        }
        
    }
    
    mutating func allReset() {
        
        comChoice = Rps(rawValue: Int.random(in: 1...3))!
    }
    
    
    
}
