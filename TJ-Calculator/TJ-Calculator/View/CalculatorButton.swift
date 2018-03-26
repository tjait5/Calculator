//
//  CalculatorButton.swift
//  Calculator
//
//  Copyright © 2018 TJ. All rights reserved.
//

import Foundation
import UIKit

class CalculatorButton : UIButton{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Customize UI of button
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        //self.layer.cornerRadius = self.frame.size.height / 2.0
        self.clipsToBounds = true
    }
    
    func inverseHighlight(){
        let currentBackgroundColor = self.backgroundColor
        self.backgroundColor = self.titleLabel?.textColor
        self.setTitleColor(currentBackgroundColor, for: UIControlState.normal)
    }
    
}
