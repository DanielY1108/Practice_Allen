//
//  SecondViewController.swift
//  BMI
//
//  Created by JinSeok Yang on 2022/09/28.
//

import UIKit

class SecondViewController: ViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    //    var number: Double?
    //    var advice: String?
    //    var matchColor: UIColor?
    
    var bmi: BMI?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // MARK: - Data
        guard let bmi = bmi else { return }
        
        resultLabel.text = "\(bmi.number)"
        resultLabel.backgroundColor = bmi.matchColor
        optionLabel.text = bmi.advice
        
    }
    
    override func setup() {
        
        view.backgroundColor = .lightGray
        
        resultLabel.font = .systemFont(ofSize: 25, weight: .bold)
        resultLabel.layer.cornerRadius = 10
        resultLabel.clipsToBounds = true
        
        optionLabel.font = .systemFont(ofSize: 20)
        
        resetButton.backgroundColor = .blue
        resetButton.setTitle("다시 계산하기", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        resetButton.layer.cornerRadius = 5
        resetButton.clipsToBounds = true
        
        
        
        
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
