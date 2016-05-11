//
//  UISliderSudoku.swift
//  AntComplexity
//
//  Created by Matt Zhu on 5/10/16.
//
//

import Foundation
import UIKit

class UISliderSudoku: UISlider {
    
    var currentEvent: UIEvent?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        currentEvent = event
    }
}