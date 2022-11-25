//
//  ViewController.swift
//  DiceGame
//
//  Created by JinSeok Yang on 2022/09/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    var diceManager = DiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImageView.image = diceManager.getFirstDice()
        secondImageView.image = diceManager.getFirstDice()
    }
    
    
    @IBAction func rollDice(_ sender: UIButton) {
        
        firstImageView.image = diceManager.getRandomDice()
        secondImageView.image = diceManager.getRandomDice()
    }
    
}

