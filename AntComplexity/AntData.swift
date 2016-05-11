//
//  AntData.swift
//  AntComplexity
//
//  Created by Matt Zhu on 5/10/16.
//
//

import Foundation

class AntData {
    
    var filledCells: Int!
    var correctCells: Int!
    
    required init(filledCells: Int, correctCells: Int) {
        self.filledCells = filledCells
        self.correctCells = correctCells
    }
    
}