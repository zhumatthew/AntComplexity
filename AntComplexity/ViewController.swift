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
//        var bestExplorationGrid = [[Int]]()
        var globalBestExplorationGrid = [[Int]]()

        
        // Represents the contents of the 9x9 grid (matrix a in the paper)
        var solutionGrid = [[Int]]()
        
        
        // If digitRow[i][digit] is true, then the digit is already present in row i
//        var digitRow = [[Bool]]()
        
        // If digitColumn[j][digit] is true, then the digit is already present in column j
//        var digitColumn = [[Bool]]()
        
        // g stands for 'global' ?
        var globalMaxSelected = 0
        
        let numCycles = 1000
        
        // evaporation rate
        let r = 0.998
        
        // The algorithm should be put into the Ant class
        // The algorithm should be passed the 'a matrix' (the solutionGrid) so that the ants can updated their personal b matrices
        
        
        // http://nshipster.com/random/
        
        
        // mb stands for maxb or maximumExplorationGrid or bestExplorationGrid
        
        // Set a maximum bound on the number of cycles or iterations
        // for all cycles
        
        let antCount = 500
        let ants = [Ant](count: antCount, repeatedValue: Ant())
        
        
        for var cycle = 0; cycle < numCycles; cycle++ {
            Ant.maxSelected = 0
            for ant in ants {
                ant.exploreGrid(solutionGrid, pheromone: pheromone)
                // ant.exploreGrid()
            } // end for all ants
            
            let deltaPheromone = Double(Ant.maxSelected) / 81.0;
            
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
                    let k = Ant.bestExplorationGrid[i][j]
                    if k != 0 {
                        pheromone[i][j][k] += deltaPheromone
                    }
                }
            }
            
            if Ant.maxSelected > globalMaxSelected {
                globalMaxSelected = Ant.maxSelected
                globalBestExplorationGrid = Ant.bestExplorationGrid
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}

