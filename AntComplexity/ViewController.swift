//
//  ViewController.swift
//  AntComplexity
//
//  Created by Matt Zhu on 4/22/16.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // Two of the three dimensions represent the coordinates of a cell of the two-dimensional grid
        // One of the dimensions represents 1 of nine 9 digits
        var pheromone = Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: 1000.0)))
        
        // Represents the contents of the 9x9 grid (matrix b in the paper)
        var explorationGrid = Array<Array<Int>>()
        var bestExplorationGrid = Array<Array<Int>>()
        var globalBestExplorationGrid = Array<Array<Int>>()

        
        // Represents the contents of the 9x9 grid (matrix a in the paper)
        var solutionGrid = Array<Array<Int>>()
        
        
        // If digitRow[i][digit] is true, then the digit is already present in row i
        var digitRow = Array<Array<Bool>>()
        
        // If digitColumn[j][digit] is true, then the digit is already present in column j
        var digitColumn = Array<Array<Bool>>()
        
        // g stands for 'global' ?
        var gmaxselected = 0
        
        let numCycles = 1000
        
        // evaporation rate
        let r = 0.998
        
        // The algorithm should be put into the Ant class
        // The algorithm should be passed the 'a matrix' (the solutionGrid) so that the ants can updated their personal b matrices
        
        
        // http://nshipster.com/random/
        
        
        // mb stands for maxb or maximumExplorationGrid or bestExplorationGrid
        
        // Set a maximum bound on the number of cycles or iterations
        // for all cycles
        for var cycle = 0; cycle < numCycles; cycle++ {
            var maxSelected = 0
            for ant in ants {
                explorationGrid = solutionGrid
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
                    if selected == 81 {
                        canSelect = false
                    }
                } // end while (canSelect)
                if selected > maxSelected {
                    maxSelected = selected
                    bestExplorationGrid = explorationGrid
                }
            } // end for all ants
            
            let deltaPheromone = Double(maxSelected) / 81.0;
            
            for i in 1...9 {
                for j in 1...9 {
                    for k in 1...9 {
                        // evaporation of pheromone
                        pheromone[i][j][k] *= r
                    }
                }
            }
            
            for i in 1...9 {
                for j in 1...9 {
                    let k = bestExplorationGrid[i][j]
                    if k != 0 {
                        pheromone[i][j][k] += deltaPheromone
                    }
                }
            }
            
            if maxSelected > gmaxselected {
                gmaxselected = maxSelected
                globalBestExplorationGrid = bestExplorationGrid
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}

