//
//  Ant.swift
//  AntComplexity
//
//  Created by Matt Zhu on 4/25/16.
//
//


// The original paper had a flaw in that its probalistic selection technique was biased toward the lower end of the index range because the indices were selected in order

// Yellow up to 50% intensity/darkness on squares to indicate pheromone and blue letters on top.
// Bold the original values?

import Foundation

class Ant {
    
    // digitRow and digitColumn should be local to an ant or global?
    static var maxSelected = 0
    
    static var bestExplorationGrid = [[Int]]()
    
    static var bestAnt = 0
    
    
    
    // do the ants all go down dead ends?
    // The issue has to do with having no digits or positions
    // Because of no digits or positions, it is impossible to make progress
    
    var selected = 0
    var explorationGrid: [[Int]]
    var id: Int
    
    init(id: Int) {
        self.id = id
        explorationGrid = [[Int]](count: 9, repeatedValue: [Int](count: 9, repeatedValue: 0))
    }
    
    // The idea is that each individual ant fills their own sudoku grid to the maximum extent possible and the ant with the most filled cells is likely to be the ant that is closest to the solution, so this ant's exploration grid has pheromone deposited it on its digit-position pairs every cycle
    
    // explorationGrid should be static field?
    
    // solutionGrid may simply be the initial grid??
    // rename to initialGrid later??
    
    // first index is the row starting at the top
    // second index is the column starting at the left
    
    // An issue exists with anything indexed with a digit in that indexing begins at 0
    
    func exploreGrid(pheromone: [[[Double]]], solutionGrid: [[Int]]) {
        
        if Ant.maxSelected == 81 {
            return
        }
        
        explorationGrid = solutionGrid

        
        // the ants are always given the starting grid anew at the start of every cycle???
        
        
        
        
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
                        selected += 1
                    }
                }
            }
            
            
            // for all digits k+1
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
                            subgridPositions[i][j][k] = positions // Before this wasn't getting assigned to 0 and values from previous iterations were interfering
                            continue;
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
                                    positions += 1
                                }
                            }
                        }
                        
                        
                        // subgridPossiblePositions[i][j][k] = number of possible positions in 3x3 sub-grid
                        subgridPositions[i][j][k] = positions
                        
                        // (When no digits can be entered into the 9x9 grid, canSelect = false)???
                        
                        // If there are no positions into which the digit can be entered into the subgrid and the digit is not already in the subgrid, then this explorationGrid cannot be the solution
//                        if positions == 0 {
//                            canSelect = false // to indicate this ^ ??
                            // Although this explorationGrid cannot be the solution, it may be too early to set canSelect to false as it may still be possible to fill other cells elsewhere in the grid
//                        }
                        
                        // As the code is, it seems that even once a digit has been entered into a subgrid, i and j will still iterate through the subgrid
                        // does the code have to exit the function if a cell is selected??
                        // If k can only be entered in one position
                        if positions == 1 && explorationGrid[i][j] == 0 {
                            
                            explorationGrid[yIndex][xIndex] = k+1 // digit index is one less than the digit
                            selected += 1
                            
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
                                count += 1
                                digit = k+1 // digit index is one less than the digit
                            }
                        }
                    }
                    digits[i][j] = count
                    
                    // The condition that the cell is empty and equal to 0 is required for count to be 1
                    // If only a single digit can be entered into the position
                    if count == 1 {
                        
                        explorationGrid[i][j] = digit
                        selected += 1
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

            // Is it wasting iterations because r is so high that none of the values of p
            // are greater than r on some cycles?
            // If so, make r random between 0 and the highest probability?
            // Random number between 0 and 1
            let r = Double(arc4random()) / Double(UINT32_MAX)
            
            var positionDigitPair1D = Array.init(0...9*9*9-1)
            positionDigitPair1D.shuffleInPlace()
            
            while positionDigitPair1D.count > 0 {
                
                let n = positionDigitPair1D.popLast()!
                let k = n % 9
                let j = ((n-k)/9)%9
                let i = (((n-k)/9)-j)/9
                if p[i][j][k] > r && subgridPositions[i][j][k] > 0 && !digitRow[i][k] && !digitColumn[j][k] && explorationGrid[i][j] == 0 {
                    
                    let subGridYCoordinate = i/3 // truncates decimal places and ranges from 0-2
                    if digitSubgrid[subGridYCoordinate*3+j/3][k] {
                        
                    }
                    
                    explorationGrid[i][j] = k+1 // digit index is one less than the digit
                    selected += 1
                    continue select
                    // break select
                }
                
            }

            // This is not really probabilistic digit selecting. It actually starts at lower numbers and increments to higher numbers
            // To make this probabilistic, then a randomly sorted array of size 9 * 81 should be created with numbers from 0 to
            // 9 * 81 - 1 and i, j, and k should be selected based on that
//            for i in 0...8 {
//                for j in 0...8 {
//                    for k in 0...8 {
//                        // for all elements of the probability matrix, compare it to the random number
//                        if p[i][j][k] > r && subgridPositions[i][j][k] > 0 && !digitRow[i][k] && !digitColumn[j][k] && explorationGrid[i][j] == 0 {
//                            
//                            explorationGrid[i][j] = k+1 // digit index is one less than the digit
//                            selected += 1
//                            continue select
////                            break select
//                        }
//                    }
//                }
//            }
            
            if selected == 81 {
                canSelect = false
            }
        } // end while (canSelect)
        
        if selected > Ant.maxSelected {
            Ant.maxSelected = selected
            Ant.bestExplorationGrid = explorationGrid
            Ant.bestAnt = id
        }

    }
}