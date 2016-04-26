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
    
    
    // do the ants all go down dead ends?
    // The issue has to do with having no digits or positions
    
    var selected = 0
    var explorationGrid: [[Int]]
    
    init(solutionGrid: [[Int]]) {
        explorationGrid = solutionGrid
    }
    
    // explorationGrid should be static field?
    
    // solutionGrid may simply be the initial grid??
    // rename to initialGrid later??
    
    // first index is the row starting at the top
    // second index is the column starting at the left
    
    // An issue exists with anything indexed with a digit in that indexing begins at 0
    
    func exploreGrid(pheromone: [[[Double]]]) {
        
        //[row 0 - row 8][digit 0 - digit 8]
        var digitRow = [[Bool]](count: 9, repeatedValue: [Bool](count: 9, repeatedValue: false))
        var digitColumn = [[Bool]](count: 9, repeatedValue: [Bool](count: 9, repeatedValue: false))
        
        var digitSubgrid = [[Bool]](count: 9, repeatedValue: [Bool](count: 9, repeatedValue: false))
        var subgridPositions = [[[Int]]](count: 9, repeatedValue: [[Int]](count: 9, repeatedValue: [Int](count: 9, repeatedValue: 0)))
        var digits = [[Int]](count: 9, repeatedValue: [Int](count: 9, repeatedValue: 0))
        
        var w = [[[Double]]](count: 9, repeatedValue: [[Double]](count: 9, repeatedValue: [Double](count: 9, repeatedValue: 0.0)))
        var p = [[[Double]]](count: 9, repeatedValue: [[Double]](count: 9, repeatedValue: [Double](count: 9, repeatedValue: 0.0)))

        
        // The next selection of a digit-position pair is possible and can be made
        // It is impossible if a digit cannot be placed in a subgrid
        var canSelect = true
                
        select: while (canSelect) {
            
            selected = 0
            
            for i in 0...8 {
                for j in 0...8 {
                    let digit = explorationGrid[i][j] // solutionGrid doesn't change? should it be explorationGrid?
                    if digit != 0 {
                        digitRow[i][digit-1] = true
                        digitColumn[j][digit-1] = true
                        // 0, 1, 2
                        // 3, 4, 5
                        // 6, 7, 8
                        digitSubgrid[(i/3)*3+j/3][digit-1] = true
                        selected++
                    }
                }
            }
            
            
            // for all digits k
            for k in 0...8 {
                for i in 0...8 {
                    for j in 0...8 {
                        
                        // to determine number of possible positions:
                        // the number of possible positions is 0 if the number is already in the subgrid
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
                                if explorationGrid[subGridYCoordinate*3+y][subGridXCoordinate*3+x] == 0 && !digitRow[subGridYCoordinate*3+y][k]
                                    && !digitColumn[subGridXCoordinate*3+x][k] {
                                    yIndex = subGridYCoordinate*3+y
                                    xIndex = subGridXCoordinate*3+x
                                    positions++
                                }
                            }
                        }
                        
                        
                        // subgridPossiblePositions[i][j][k] = number of possible positions in 3x3 sub-grid
                        subgridPositions[i][j][k] = positions
                        
                        // (When no digits can be entered into the 9x9 grid, canSelect = false)???
                        
                        // If there are no positions into which the digit can be entered into the subgrid and the digit is not already in the subgrid, then this explorationGrid cannot be the solution
                        if positions == 0 {
                            canSelect = false // to indicate this ^ ??
                        }
                        
                        // As the code is, it seems that even once a digit has been entered into a subgrid, i and j will still iterate through the subgrid
                        // does the code have to exit the function if a cell is selected??
                        // If k can only be entered in one position
                        if positions == 1 {
                            explorationGrid[yIndex][xIndex] = k+1 // digit index is one less than the digit
                            selected++
                            
                            // perhaps it should be continue, but canSelect should be set to false when no digits can be entered into the 9x9 grid
                            continue select
//                            break select
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
                        for k in 0...8 {
                            // If the number of possible positions for the digit in the subgrid is greater than 0 and the digit is not in the column or row
                            if subgridPositions[i][j][k] > 0 && !digitRow[i][k] && !digitColumn[j][k] {
                                count++
                                digit = k+1 // digit index is one less than the digit
                            }
                        }
                    }
                    digits[i][j] = count
                    
                    // If only a single digit can be entered into the position
                    if count == 1 {
                        explorationGrid[i][j] = digit
                        selected++
                        continue select
//                        break select
                    }

                    // even if subgridPossiblePositions is > 0, if it was 1, then the digit was entered into a position and it is never decremented to 0?
                    // how many digits can be entered in a single position?
                    // probably need to check for each digit k in 1...9 if it is in digitRow, digitColumn, and that subgridPossiblePositions[i][j][k] is > 0
 
                }
            }
            
            for i in 0...8 {
                for j in 0...8 {
                    for k in 0...8 {
                        w[i][j][k] = pheromone[i][j][k] * Double((10-subgridPositions[i][j][k])*(10-digits[i][j]))
                    }
                }
            }
            
            // If all elements digits or positions are <= 1, then canSelect must be set to false
            var someDigits = false
            var somePositions = false
            for i in 0...8 {
                for j in 0...8 {
                    if digits[i][j] > 1 {
                        someDigits = true
                    }
                    for k in 0...8 {
                        if subgridPositions[i][j][k] > 1 {
                            somePositions = true
                        }
                    }
                }
            }
            
            if !someDigits || !somePositions {
                canSelect = false
            }
            
            
            // There are digits which can be entered into more than one position and and there are positions which can be filled with more than one digit
            
            // flatten from 3D to 1D and reduce by adding
            let sumw = w.flatMap{$0}.flatMap{$0}.reduce(0, combine: +)
            
            // divides each element of w by sumw, multiplies by 81 since there are 81 cells
            // this effectively divides the w value for each position-digit pair by the average w value
            p = w.map({ $0.map({ $0.map({ $0 * 81 / sumw }) }) })

            
            // p = w.map(<#T##transform: ([[Double]]) throws -> T##([[Double]]) throws -> T#>)

            
            // Random number between 0 and 1
            let r = Double(arc4random()) / Double(UINT32_MAX)
            
            for i in 0...8 {
                for j in 0...8 {
                    for k in 0...8 {
                        // for all elements of the probability matrix, compare it to the random number
                        if p[i][j][k] > r && subgridPositions[i][j][k] > 0 && !digitRow[i][k] && !digitColumn[j][k] {
                            explorationGrid[i][j] = k+1 // digit index is one less than the digit
                            selected++
                            continue select
//                            break select
                        }
                    }
                }
            }
            
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