//
//  Ant.swift
//  AntComplexity
//
//  Created by Matt Zhu on 4/25/16.
//
//

import Foundation

class Ant {
    
    // digitRow and digitColumn should be local to an ant or global?
    static var maxSelected = 0
    static var bestExplorationGrid = [[Int]]()
    
    // solutionGrid may simply be the initial grid??
    // rename to initialGrid later??
    
    func exploreGrid(solutionGrid: [[Int]], pheromone: [[[Double]]]) {
        
        var digitRow = [[Bool]]()
        var digitColumn = [[Bool]]()

        
        var explorationGrid = solutionGrid
        var selected = 0
        
        // The next selection of a digit-position pair is possible and can be made
        var canSelect = true
        
        while (canSelect) {
            for i in 1...9 {
                for j in 1...9 {
                    let digit = solutionGrid[i][j]
                    if digit != 0 {
                        digitRow[i][digit] = true
                        digitColumn[j][digit] = true
                        selected++
                    }
                }
            }
            // for all digits k
            for k in 1...9 {
                for i in 1...9 {
                    for j in 1...9 {
                        // subgridPossiblePositions[i][j][k] = number of possible positions in 3x3 sub-grid
                        
                        // to determine number of possible positions:
                        // the number of possible positions is 0 if the number is in the subgrid, break
                        // 9 possible positions minus positions in which the digit is already in the row or column minus the number of digits already in the subgrid
                        var positions = 0
                        let subGridXCoordinate = i/3 // truncates decimal places and ranges from 0-2
                        let subGridYCoordinate = j/3
                        for x in 0...2 {
                            for y in 0...2 {
                                
                                // if
                            }
                        }
                        
                        // When no digits can be entered into the 9x9 grid, canSelect = false
                        // If k can only be entered in one position, then explorationGrid[i][j] = k
                        // selected++
                        
                        
                        
                        // There are digits which can be entered into more than one position and
                    }
                }
            }
            
            
            // for all positions in the 9x9 grid
            for i in 1...9 {
                for j in 1...9 {
                    // how many digits can be entered in a single position?
                    // probably need to check for each digit k in 1...9 if it is in digitRow, digitColumn, and that subgridPossiblePositions[i][j][k] is > 0
                    // If only a single digit can be entered into the position
                    // then explorationGrid[i][j] = k, the digit is entered into the position
                    // selected++
                    
                }
            }
            
            
            // sump = p.reduce(0, combine: +)
            
            if selected == 81 {
                canSelect = false
            }
        } // end while (canSelect)
        if selected > Ant.maxSelected {
            Ant.maxSelected = selected
            Ant.bestExplorationGrid = explorationGrid
        }

    }
}