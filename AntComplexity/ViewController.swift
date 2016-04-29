//
//  ViewController.swift
//  AntComplexity
//
//  Created by Matt Zhu on 4/22/16.
//
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var antCountLabel: UILabel!
    @IBOutlet weak var selectedCountLabel: UILabel!
    @IBOutlet weak var cycleCountLabel: UILabel!
    
    // http://www.extremesudoku.info/sudoku.html
    
    // Make the starting grid / solution grid orange background and bold blue text
    // Two things to implement:
    // When the solution is found, move the slider to the value of the ant and display the solution and disable the slider
    // 3x3 sections should be bold
    
    // Base
    //    let solutionGrid = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    
    // Easiest
    //    let solutionGrid = [[0,0,0,2,6,0,7,0,1],[6,8,0,0,7,0,0,9,0],[1,9,0,0,0,4,5,0,0],[8,2,0,1,0,0,0,4,0],[0,0,4,6,0,2,9,0,0],[0,5,0,0,0,3,0,2,8],[0,0,9,3,0,0,0,7,4],[0,4,0,0,5,0,0,3,6],[7,0,3,0,1,8,0,0,0]]
    
    // Intermediate
//    let solutionGrid = [[0,2,0,6,0,8,0,0,0],[5,8,0,0,0,9,7,0,0],[0,0,0,0,4,0,0,0,0],[3,7,0,0,0,0,5,0,0],[6,0,0,0,0,0,0,0,4],[0,0,8,0,0,0,0,1,3],[0,0,0,0,2,0,0,0,0],[0,0,9,8,0,0,0,3,6],[0,0,0,3,0,6,0,9,0]]
    
    // Difficult
//    let solutionGrid = [[0,0,0,6,0,0,4,0,0],[7,0,0,0,0,3,6,0,0],[0,0,0,0,9,1,0,8,0],[0,0,0,0,0,0,0,0,0],[0,5,0,1,8,0,0,0,3],[0,0,0,3,0,6,0,4,5],[0,4,0,2,0,0,0,6,0],[9,0,3,0,0,0,0,0,0],[0,2,0,0,0,0,1,0,0]]
    
    // Difficult #2
    let solutionGrid = [[2,0,0,3,0,0,0,0,0],[8,0,4,0,6,2,0,0,3],[0,1,3,8,0,0,2,0,0],[0,0,0,0,2,0,3,9,0],[5,0,7,0,0,0,6,2,1],[0,3,2,0,0,6,0,0,0],[0,2,0,0,0,9,1,4,0],[6,0,1,2,5,0,8,0,9],[0,0,0,0,0,1,0,0,2]]
    
    // Not fun
//    let solutionGrid = [[0,2,0,0,0,0,0,0,0],[0,0,0,6,0,0,0,0,3],[0,7,4,0,8,0,0,0,0],[0,0,0,0,0,3,0,0,2],[0,8,0,0,4,0,0,1,0],[6,0,0,5,0,0,0,0,0],[0,0,0,0,1,0,7,8,0],[5,0,0,0,0,9,0,0,0],[0,0,0,0,0,0,0,4,0]]
    
    // Evil
//    let solutionGrid = [[4,0,3,0,0,0,1,0,0],[0,0,0,3,0,0,0,0,5],[0,0,0,0,2,1,7,0,0],[0,3,0,0,0,6,0,0,2],[0,5,0,0,4,0,0,3,0],[1,0,0,5,0,0,0,6,0],[0,0,8,6,9,0,0,0,0],[7,0,0,0,0,3,0,0,0],[0,0,4,0,0,0,2,0,9]]
    
    // The one in the paper
//    let solutionGrid = [[0,3,0,0,0,0,0,5,0],[0,0,1,8,0,0,0,0,0],[2,0,0,5,0,0,0,4,1],[3,0,6,4,0,0,0,0,0],[0,0,0,1,7,2,0,0,0],[0,0,0,0,0,8,7,0,4],[7,8,0,0,0,4,0,0,5],[0,0,0,0,0,3,0,0,0],[0,9,0,0,0,0,6,2,0]]

    var startingCells: [[Bool]]!
    
    // Bold the solution grid/starting grid?
    
    var pheromone = Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: 1000.0)))

    var antCount = 500
    var ants = [Ant]()

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! UICollectionViewCellSudoku
        let row = indexPath.row / 9
        let column = indexPath.row % 9
        
        cell.indexPath = indexPath
        // Can't really show pheromone due to the three dimesional nature involving the digits
        
        // 1.0 is fully opaque, 0.0 is fully transparent
//        cell.contentView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5) // Comment this out?

        
        // UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        
        if startingCells[row][column] {
            cell.contentView.backgroundColor = UIColor.orangeColor()
        }
        
        // Slider was disabled before the solve button was pressed, which is why the cell label text is set to the solution grid cell
        if slider.enabled || Ant.maxSelected == 81 {
            // fatal error: Array index out of range
            let digit = ants[Int(slider.value)].explorationGrid[row][column]
            cell.label.text = "\(digit)"
            if digit > 0 {
                if !startingCells[row][column] {
                    let minPheromone = pheromone.flatMap{$0}.flatMap{$0}.minElement()
                    let maxPheromone = pheromone.flatMap{$0}.flatMap{$0}.maxElement()
                    let opacityScale = (maxPheromone!-minPheromone!) != 0 ? CGFloat((pheromone[row][column][digit-1] - minPheromone!) / (maxPheromone!-minPheromone!)) : 0
                    cell.contentView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5 + 0.5 * opacityScale)
                }
            } else {
                cell.contentView.backgroundColor = UIColor.whiteColor()
            }

        } else {
            cell.label.text = "\(solutionGrid[row][column])"
        }
        
        cell.label.textColor = UIColor.blueColor()
        
//        let label = UILabel()
//        label.text = "6"
//        label.sizeToFit()
//        cell.contentView.addSubview(label);
        return cell
//        let cell = tableView.dequeueReusableCellWithIdentifier("ThreadCell", forIndexPath: indexPath)
//        configureCell(cell, indexPath: indexPath)
//        return cell
    }
    
//    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
//        let talk = fetchedResultsController.objectAtIndexPath(indexPath) as! TalkMO
//        cell.textLabel?.text = talk.title
//        
//        if let lastMsg = talk.lastMessage where lastMsg.isNotEmpty {
//            cell.detailTextLabel?.text = lastMsg
//        } else {
//            cell.detailTextLabel?.text = talk.talkDescription
//        }
//        
//        let accessoryLabel = UILabel()
//        accessoryLabel.text = "Nov 16"
//        accessoryLabel.attributedText = NSAttributedString(string: "Nov 16", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12)])
//        accessoryLabel.sizeToFit()
//        cell.accessoryView = accessoryLabel
//        
//        cell.imageView?.image = talk.image
//        cell.imageView?.layer.cornerRadius = 4.0
//        cell.imageView?.layer.masksToBounds = true
//    }
    
    @IBAction func sliderValueDidChange(sender: UISlider) {
        let i = Int(slider.value)
        antCountLabel.text = "Ant #\(i+1)"
        selectedCountLabel.text = "selected: \(ants[i].selected)"
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayoutSudoku()
        slider.maximumValue = Float(antCount - 1)
        slider.enabled = false
        
        startingCells = solutionGrid.map({ $0.map({ $0 > 0 }) })
        
//        self.collectionView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func solve(sender: UIButton) {
        slider.enabled = true
        sender.enabled = false
        
        let queue = dispatch_queue_create("SolverQueue", DISPATCH_QUEUE_SERIAL)
        
        // break reference cycles?
        dispatch_async(queue) { () -> Void in
            // Two of the three dimensions represent the coordinates of a cell of the two-dimensional grid
            // One of the dimensions represents 1 of nine 9 digits
            
            // Represents the contents of the 9x9 grid (matrix b in the paper)
            //        var bestExplorationGrid = [[Int]]()
            var globalBestExplorationGrid = [[Int]]()
            
            
            // call this starting grid?
            // Represents the contents of the 9x9 grid (matrix a in the paper)
            //        let solutionGrid = [[Int]]()
            
            
            
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
            
            
            for id in 0..<self.antCount {
                self.ants.append(Ant(id: id))
            }
            // http://nshipster.com/random/
            
            
            // mb stands for maxb or maximumExplorationGrid or bestExplorationGrid
            
            // Set a maximum bound on the number of cycles or iterations
            // for all cycles
            
            
            
            for cycle in 0 ..< numCycles {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.cycleCountLabel.text = "cycles: \(cycle)"
                })
                
                Ant.maxSelected = 0
                for ant in self.ants {
                    ant.exploreGrid(self.pheromone, solutionGrid: self.solutionGrid)
                } // end for all ants
                
                let deltaPheromone = Double(Ant.maxSelected) / 81.0;
                
                // multiply each element by decay constant to emulate evaporation of pheromone
                self.pheromone = self.pheromone.map({ $0.map({ $0.map({ $0 * r }) }) })
                
                for i in 0...8 {
                    for j in 0...8 {
                        let digit = Ant.bestExplorationGrid[i][j]
                        if digit != 0 {
                            self.pheromone[i][j][digit-1] += deltaPheromone
                        }
                    }
                }
                
                if Ant.maxSelected > globalMaxSelected {
                    globalMaxSelected = Ant.maxSelected
                    globalBestExplorationGrid = Ant.bestExplorationGrid
                    
                    if globalMaxSelected == 81 {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            print("Best ant: \(Ant.bestAnt+1)")
                            self.slider.enabled = false
                            self.slider.value = Float(Ant.bestAnt)
                            self.sliderValueDidChange(self.slider)
                            
                            // UIControlEventTouchCancel
                            
                        })
                        return
                    }
                    
                }

            }
            // end of all cycles
        }
        
        
    }


}

