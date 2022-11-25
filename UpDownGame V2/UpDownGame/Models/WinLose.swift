//
//  WinLose.swift
//  UpDownGame
//
//  Created by JinSeok Yang on 2022/10/01.
//

import UIKit

enum WinLose {
    case tryCount
    case win
    case lose
    
    var countWL: (Int) {
        
        switch self {
        case .tryCount:
            return +1
        case .win:
            return +1
        case .lose:
            return +1
        }
    }

}
