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
    @IBOutlet weak var slider: UISliderSudoku!
    @IBOutlet weak var antCountLabel: UILabel!
    @IBOutlet weak var selectedCountLabel: UILabel!
    @IBOutlet weak var cycleCountLabel: UILabel!
    
    // http://www.extremesudoku.info/sudoku.html
    
    // Make the starting grid / solution grid orange background and bold blue text
    // Two things to implement:
    // When the solution is found, move the slider to the value of the ant and display the solution and disable the slider
    // 3x3 sections should be bold
    
    // Base
    var solutionGrid = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    
    // Easiest
//        let solutionGrid = [[0,0,0,2,6,0,7,0,1],[6,8,0,0,7,0,0,9,0],[1,9,0,0,0,4,5,0,0],[8,2,0,1,0,0,0,4,0],[0,0,4,6,0,2,9,0,0],[0,5,0,0,0,3,0,2,8],[0,0,9,3,0,0,0,7,4],[0,4,0,0,5,0,0,3,6],[7,0,3,0,1,8,0,0,0]]
    
    // Intermediate
//    let solutionGrid = [[0,2,0,6,0,8,0,0,0],[5,8,0,0,0,9,7,0,0],[0,0,0,0,4,0,0,0,0],[3,7,0,0,0,0,5,0,0],[6,0,0,0,0,0,0,0,4],[0,0,8,0,0,0,0,1,3],[0,0,0,0,2,0,0,0,0],[0,0,9,8,0,0,0,3,6],[0,0,0,3,0,6,0,9,0]]
    
    // Difficult
//    let solutionGrid = [[0,0,0,6,0,0,4,0,0],[7,0,0,0,0,3,6,0,0],[0,0,0,0,9,1,0,8,0],[0,0,0,0,0,0,0,0,0],[0,5,0,1,8,0,0,0,3],[0,0,0,3,0,6,0,4,5],[0,4,0,2,0,0,0,6,0],[9,0,3,0,0,0,0,0,0],[0,2,0,0,0,0,1,0,0]]
    
    // Difficult #2
//    let solutionGrid = [[2,0,0,3,0,0,0,0,0],[8,0,4,0,6,2,0,0,3],[0,1,3,8,0,0,2,0,0],[0,0,0,0,2,0,3,9,0],[5,0,7,0,0,0,6,2,1],[0,3,2,0,0,6,0,0,0],[0,2,0,0,0,9,1,4,0],[6,0,1,2,5,0,8,0,9],[0,0,0,0,0,1,0,0,2]]
    
    // Not fun
//    let solutionGrid = [[0,2,0,0,0,0,0,0,0],[0,0,0,6,0,0,0,0,3],[0,7,4,0,8,0,0,0,0],[0,0,0,0,0,3,0,0,2],[0,8,0,0,4,0,0,1,0],[6,0,0,5,0,0,0,0,0],[0,0,0,0,1,0,7,8,0],[5,0,0,0,0,9,0,0,0],[0,0,0,0,0,0,0,4,0]]
    
    // Evil
//    let solutionGrid = [[4,0,3,0,0,0,1,0,0],[0,0,0,3,0,0,0,0,5],[0,0,0,0,2,1,7,0,0],[0,3,0,0,0,6,0,0,2],[0,5,0,0,4,0,0,3,0],[1,0,0,5,0,0,0,6,0],[0,0,8,6,9,0,0,0,0],[7,0,0,0,0,3,0,0,0],[0,0,4,0,0,0,2,0,9]]
    
    // The one in the paper (is this impossible?)
//    let solutionGrid = [[0,3,0,0,0,0,0,5,0],[0,0,1,8,0,0,0,0,0],[2,0,0,5,0,0,0,4,1],[3,0,6,4,0,0,0,0,0],[0,0,0,1,7,2,0,0,0],[0,0,0,0,0,8,7,0,4],[7,8,0,0,0,4,0,0,5],[0,0,0,0,0,3,0,0,0],[0,9,0,0,0,0,6,2,0]]
    
    // 18 minutes, took us 12
//    var solutionGrid = [[8,0,0,0,0,0,0,0,0],[0,0,3,6,0,0,0,0,0],[0,7,0,0,9,0,2,0,0],[0,5,0,0,0,7,0,0,0],[0,0,0,0,4,5,7,0,0],[0,0,0,1,0,0,0,3,0],[0,0,1,0,0,0,0,6,8],[0,0,8,5,0,0,0,1,0],[0,9,0,0,0,0,4,0,0]]
    
    // 7 seconds
//    let solutionGrid = [[8,4,2,0,0,0,0,0,0],[0,0,0,5,0,1,7,0,0],[0,0,0,0,0,0,3,8,0],[9,5,0,0,0,0,0,0,2],[0,0,0,0,5,0,0,0,0],[0,0,0,0,0,0,0,4,6],[1,0,0,0,0,7,4,0,0],[0,0,8,0,6,0,0,0,0],[0,0,4,0,0,0,0,3,8]]
    
    // Extreme?
//    let solutionGrid = [[0,0,5,1,0,0,0,0,6],[0,1,0,0,7,0,0,2,0],[7,0,0,0,0,8,5,0,0],[6,0,0,0,0,4,3,0,0],[0,8,0,0,6,0,0,5,0],[0,0,2,9,0,0,0,0,1],[0,0,1,3,0,0,0,0,9],[0,4,0,0,8,0,0,6,0],[5,0,0,0,0,1,2,0,0]]
    
    // 18 min solution
//    var fullSolutionGrid = [[8,1,2,7,5,3,6,4,9],[9,4,3,6,8,2,1,7,5],[6,7,5,4,9,1,2,8,3],[1,5,4,2,3,7,8,9,6],[3,6,9,8,4,5,7,2,1],[2,8,7,1,6,9,5,3,4],[5,2,1,9,7,4,3,6,8],[4,3,8,5,2,6,9,1,7],[7,9,6,3,1,8,4,5,2]]
    
    // not fun solution
//    var fullSolutionGrid = [[1,2,6,4,3,7,9,5,8],[8,9,5,6,2,1,4,7,3],[3,7,4,9,8,5,1,2,6],[4,5,7,1,9,3,8,6,2],[9,8,3,2,4,6,5,1,7],[6,1,2,5,7,8,3,9,4],[2,6,9,3,1,4,7,8,5],[5,4,8,7,6,9,2,3,1],[7,3,1,8,5,2,6,4,9]]
    
//    var allPuzzles = [[[0,0,0,2,6,0,7,0,1],[6,8,0,0,7,0,0,9,0],[1,9,0,0,0,4,5,0,0],[8,2,0,1,0,0,0,4,0],[0,0,4,6,0,2,9,0,0],[0,5,0,0,0,3,0,2,8],[0,0,9,3,0,0,0,7,4],[0,4,0,0,5,0,0,3,6],[7,0,3,0,1,8,0,0,0]]]
    
    // AI Escargot
//    var allPuzzles = [[[1,0,0,0,0,7,0,9,0],[0,3,0,0,2,0,0,0,8],[0,0,9,6,0,0,5,0,0],[0,0,5,3,0,0,9,0,0],[0,1,0,0,8,0,0,0,2],[6,0,0,0,0,4,0,0,0],[3,0,0,0,0,0,0,1,0],[0,4,0,0,0,0,0,0,7],[0,0,7,0,0,0,3,0,0]]]
    
//    var allPuzzles = [[[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]]
    
    // AI killer
    var allPuzzles = [[[0,0,0,0,0,0,0,7,0],[0,6,0,0,1,0,0,0,4],[0,0,3,4,0,0,2,0,0],[8,0,0,0,0,3,0,5,0],[0,0,2,9,0,0,7,0,0],[0,4,0,0,8,0,0,0,9],[0,2,0,0,6,0,0,0,7],[0,0,0,1,0,0,9,0,0],[7,0,0,0,0,8,0,6,0]]]


    var startingCells: [[Bool]]!
    
    // Bold the solution grid/starting grid?
    
    var antData = [AntData]()

    
    var pheromone = Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: 1000.0)))

    var antCount = 30
    var ants = [Ant]()

    @IBOutlet var puzzleButtons: [UIButton]!
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBAction func switchPuzzle(sender: UIButton) {
        solutionGrid = allPuzzles[sender.tag]
        startingCells = solutionGrid.map({ $0.map({ $0 > 0 }) })
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! UICollectionViewCellSudoku
        let row = indexPath.row / 9
        let column = indexPath.row % 9
        
        if let _ = cell.topLineView {
            cell.topLineView.hidden = true
            cell.bottomLineView.hidden = true
            cell.leftLineView.hidden = true
            cell.rightLineView.hidden = true
            
            if column == 0 {
                cell.leftLineView.hidden = false
            } else if (column + 1) % 3 == 0 {
                cell.rightLineView.hidden = false
            }
            
            if row == 0 {
                cell.topLineView.hidden = false
            } else if (row + 1) % 3 == 0 {
                cell.bottomLineView.hidden = false
            }
        }
        
//        cell.indexPath = indexPath
        // Can't really show pheromone due to the three dimesional nature involving the digits
        
        // 1.0 is fully opaque, 0.0 is fully transparent
//        cell.contentView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5) // Comment this out?

        
        // UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        
        if startingCells[row][column] {
            cell.contentView.backgroundColor = UIColor.orangeColor()
        } else {
            cell.contentView.backgroundColor = UIColor.whiteColor()
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
    
    @IBAction func sliderValueDidChange(sender: UISliderSudoku) {
        let i = Int(slider.value)
        antCountLabel.text = "Ant #\(i+1)"
        selectedCountLabel.text = "selected: \(ants[i].selected)"
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allPuzzles.append([[0,2,0,6,0,8,0,0,0],[5,8,0,0,0,9,7,0,0],[0,0,0,0,4,0,0,0,0],[3,7,0,0,0,0,5,0,0],[6,0,0,0,0,0,0,0,4],[0,0,8,0,0,0,0,1,3],[0,0,0,0,2,0,0,0,0],[0,0,9,8,0,0,0,3,6],[0,0,0,3,0,6,0,9,0]])
        allPuzzles.append([[0,0,0,6,0,0,4,0,0],[7,0,0,0,0,3,6,0,0],[0,0,0,0,9,1,0,8,0],[0,0,0,0,0,0,0,0,0],[0,5,0,1,8,0,0,0,3],[0,0,0,3,0,6,0,4,5],[0,4,0,2,0,0,0,6,0],[9,0,3,0,0,0,0,0,0],[0,2,0,0,0,0,1,0,0]])
        allPuzzles.append([[2,0,0,3,0,0,0,0,0],[8,0,4,0,6,2,0,0,3],[0,1,3,8,0,0,2,0,0],[0,0,0,0,2,0,3,9,0],[5,0,7,0,0,0,6,2,1],[0,3,2,0,0,6,0,0,0],[0,2,0,0,0,9,1,4,0],[6,0,1,2,5,0,8,0,9],[0,0,0,0,0,1,0,0,2]])
        allPuzzles.append([[4,0,3,0,0,0,1,0,0],[0,0,0,3,0,0,0,0,5],[0,0,0,0,2,1,7,0,0],[0,3,0,0,0,6,0,0,2],[0,5,0,0,4,0,0,3,0],[1,0,0,5,0,0,0,6,0],[0,0,8,6,9,0,0,0,0],[7,0,0,0,0,3,0,0,0],[0,0,4,0,0,0,2,0,9]])
        allPuzzles.append([[0,2,0,0,0,0,0,0,0],[0,0,0,6,0,0,0,0,3],[0,7,4,0,8,0,0,0,0],[0,0,0,0,0,3,0,0,2],[0,8,0,0,4,0,0,1,0],[6,0,0,5,0,0,0,0,0],[0,0,0,0,1,0,7,8,0],[5,0,0,0,0,9,0,0,0],[0,0,0,0,0,0,0,4,0]])
        allPuzzles.append([[8,0,0,0,0,0,0,0,0],[0,0,3,6,0,0,0,0,0],[0,7,0,0,9,0,2,0,0],[0,5,0,0,0,7,0,0,0],[0,0,0,0,4,5,7,0,0],[0,0,0,1,0,0,0,3,0],[0,0,1,0,0,0,0,6,8],[0,0,8,5,0,0,0,1,0],[0,9,0,0,0,0,4,0,0]])
        allPuzzles.append([[0,3,0,0,0,0,0,5,0],[0,0,1,8,0,0,0,0,0],[2,0,0,5,0,0,0,4,1],[3,0,6,4,0,0,0,0,0],[0,0,0,1,7,2,0,0,0],[0,0,0,0,0,8,7,0,4],[7,8,0,0,0,4,0,0,5],[0,0,0,0,0,3,0,0,0],[0,9,0,0,0,0,6,2,0]])
        
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayoutSudoku()
        slider.maximumValue = Float(antCount - 1)
        slider.enabled = false
        
        solutionGrid = allPuzzles.first!
        startingCells = solutionGrid.map({ $0.map({ $0 > 0 }) })
        
//        self.collectionView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func solve(sender: UIButton) {
        
        let startTime = CACurrentMediaTime()
        
        for button in puzzleButtons {
            button.enabled = false
//            button.disable
        }
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
//                    self.antData.append(AntData(filledCells: ant.selected, correctCells: ant.compareSolutionGrid(self.fullSolutionGrid)))
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
                            
                            self.slider.cancelTrackingWithEvent(self.slider.currentEvent)
                            
                            self.slider.enabled = false
                            self.slider.value = Float(Ant.bestAnt)
                            self.sliderValueDidChange(self.slider)
                            
                            
                            let elapsedTime = CACurrentMediaTime() - startTime
                            self.resultsLabel.text = "Solved in: \(String(format: "%5.4f", elapsedTime)) seconds"

//                            self.logData()
                            
                        })
                        return
                    }
                    
                }

            }
            // end of all cycles
        }
        
        
    }
    
    func logData() {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let dataDir = dirPaths.first!.stringByAppendingString("/data/")
        let filemgr = NSFileManager.defaultManager()
        if !filemgr.fileExistsAtPath(dataDir) {
            do {
                try filemgr.createDirectoryAtPath(dataDir, withIntermediateDirectories: false, attributes: nil)
            } catch let error {
                print(error)
            }
        }
        
        
        //        let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        
        let fileName = "antdata.txt"
        let dataFilePath = dataDir.stringByAppendingString(fileName)
        let pathURL = NSURL.init(fileURLWithPath: dataFilePath)
        
        let dataWidth = 14
        
        // Since different image files have different sizes, it may be useful to also have the image size
        // Image Size, latency, duration (total duration of request), local processing time for image
        let headings = ["%FilledCells", "CorrectCells"]
        var header = ""
        for heading in headings {
            let padding = "".stringByPaddingToLength(dataWidth-heading.characters.count, withString: " ", startingAtIndex: 0)
            header += padding + heading
        }
        var text = ""
        
        for data in self.antData {
            text += String(format: "\n%\(dataWidth)d", data.filledCells)
            text += String(format: "%\(dataWidth)d", data.correctCells)
        }
        
        let combinedtext = header + text
        print("Datapath: \(pathURL)")
        
        do {
            // writing to disk
            
            try combinedtext.writeToURL(pathURL, atomically: true, encoding: NSUTF8StringEncoding)
            
            // saving was successful. any code posterior code goes here
            
            // reading from disk
            //            do {
            //                let mytext = try String(contentsOfURL: pathURL, encoding: NSUTF8StringEncoding)
            //                print(mytext)   // "some text\n"
            //            } catch let error as NSError {
            //                print("error loading from url \(pathURL)")
            //                print(error.localizedDescription)
            //            }
        } catch let error as NSError {
            print("error writing to url \(pathURL)")
            print(error.localizedDescription)
        }
        
    }


}

