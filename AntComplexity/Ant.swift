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
    
    // explorationGrid should be static field?
    
    // solutionGrid may simply be the initial grid??
    // rename to initialGrid later??
    
    // first index is the row starting at the top
    // second index is the column starting at the left
    
    func exploreGrid(solutionGrid: [[Int]], pheromone: [[[Double]]]) {
        
        var digitRow = [[Bool]]()
        var digitColumn = [[Bool]]()
        var digitSubgrid = [[Bool]]()
        var subgridPositions = [[[Int]]]()
        var digits = [[Int]]()

        var explorationGrid = solutionGrid
        var selected = 0
        
        // The next selection of a digit-position pair is possible and can be made
        // It is impossible if a digit cannot be placed in a subgrid
        var canSelect = true
        
        select: while (canSelect) {
            for i in 0...8 {
                for j in 0...8 {
                    let digit = explorationGrid[i][j] // solutionGrid doesn't change? should it be explorationGrid?
                    if digit != 0 {
                        digitRow[i][digit] = true
                        digitColumn[j][digit] = true
                        // 0, 1, 2
                        // 3, 4, 5
                        // 6, 7, 8
                        digitSubgrid[(i/3)*3+j/3][digit] = true
                        selected++
                    }
                }
            }
            // for all digits k
            for k in 1...9 {
                for i in 0...8 {
                    for j in 0...8 {
                        // subgridPossiblePositions[i][j][k] = number of possible positions in 3x3 sub-grid
                        
                        // to determine number of possible positions:
                        // the number of possible positions is 0 if the number is in the subgrid, break
                        // 9 possible positions minus positions in which the digit is already in the row or column minus the number of digits already in the subgrid
                        var positions = 0
                        
                        let subGridYCoordinate = i/3 // truncates decimal places and ranges from 0-2
                        let subGridXCoordinate = j/3
                        
                        // If the digit is already in the subgrid, there are no positions
                        if digitSubgrid[subGridYCoordinate*3+j/3][k] {
                            break;
                        }
                        
                        var yIndex = 0
                        var xIndex = 0
                        for y in 0...2 {
                            for x in 0...2 {
                                // If the grid cell is empty and the digit is not in the row or column then increment positions
                                if solutionGrid[subGridYCoordinate*3+y][subGridXCoordinate*3+x] == 0 && !digitRow[subGridYCoordinate*3+y][k] && !digitColumn[subGridXCoordinate*3+x][k] {
                                    yIndex = subGridYCoordinate*3+y
                                    xIndex = subGridXCoordinate*3+x
                                    positions++
                                }
                            }
                        }
                        
                        subgridPositions[i][j][k] = positions
                        
                        // (When no digits can be entered into the 9x9 grid, canSelect = false)???
                        
                        // If there are no positions into which the digit can be entered into the subgrid and the digit is not already in the subgrid, then this explorationGrid cannot be the solution
                        canSelect = false // to indicate this ^ ??
                        
                        // As the code is, it seems that even once a digit has been entered into a subgrid, i and j will still iterate through the subgrid
                        // does the code have to exit the function if a cell is selected??
                        // If k can only be entered in one position
                        if positions == 1 {
                            explorationGrid[yIndex][xIndex] = k
                            selected++
                            continue select
                        }
                        
                    }
                }
                

                

            }
            
            
            // for all positions in the 9x9 grid
            for i in 0...8 {
                for j in 0...8 {
                    
                    // If the cell is empty
                    var count = 0
                    var digit = 0
                    if explorationGrid[i][j] == 0 {
                        for k in 1...9 {
                            // If the number of possible positions for the digit in the subgrid is greater than 0 and the digit is not in the column or row
                            if subgridPositions[i][j][k] > 0 && !digitRow[i][k] && !digitColumn[i][k] {
                                count++
                                digit = k
                            }
                        }
                    }
                    digits[i][j] = count
                    
                    // If only a single digit can be entered into the position
                    if count == 1 {
                        explorationGrid[i][j] = digit
                        selected++
                        continue select
                    }

                    // even if subgridPossiblePositions is > 0, if it was 1, then the digit was entered into a position and it is never decremented to 0?
                    // how many digits can be entered in a single position?
                    // probably need to check for each digit k in 1...9 if it is in digitRow, digitColumn, and that subgridPossiblePositions[i][j][k] is > 0
 
                }
            }
            
            // There are digits which can be entered into more than one position and and there are positions which can be filled with more than one digit
//            let wFlat = w.flatMap { $0 }
//            sumw = w.reduce(0, combine: +)

            
            
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