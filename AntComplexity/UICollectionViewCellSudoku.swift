//
//  UICollectionViewCellSudoku.swift
//  AntComplexity
//
//  Created by Matt Zhu on 4/26/16.
//
//

import Foundation
import UIKit

class UICollectionViewCellSudoku: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var indexPath: NSIndexPath!
    
    var topLineView: UIView!
    var bottomLineView: UIView!
    var leftLineView: UIView!
    var rightLineView: UIView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLineViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addLineViews()
    }
    
//    [15:20:44]  <weaksauce>	you can hack it and do a dispatch_once thing in drawRect()
//    [15:20:49]  <weaksauce>	and call addLineViews from that
    
    func addLineViews() {
//        topLineView = UIView(frame: CGRectMake(0.0, 0.5, self.bounds.width, 1.5))
//        topLineView.backgroundColor = UIColor.blackColor()
//        contentView.addSubview(topLineView)
        bottomLineView = UIView(frame: CGRectMake(0.0, self.bounds.height-2.0, self.bounds.width, 1.5))
        bottomLineView.backgroundColor = UIColor.redColor()
        contentView.addSubview(bottomLineView)
        leftLineView = UIView(frame: CGRectMake(0.5, 0.0, 1.5, self.bounds.height))
        leftLineView.backgroundColor = UIColor.greenColor()
        contentView.addSubview(leftLineView)
        rightLineView = UIView(frame: CGRectMake(self.bounds.width-2.0, 0.0, 1.5, self.bounds.height))
        rightLineView.backgroundColor = UIColor.redColor()
        contentView.addSubview(rightLineView)
        
        print("boundswidth: ", self.bounds.width)
        print("contentview bounds: ", self.contentView.bounds.width)
        
        
//        rightLineView = UIView(frame: CGRectMake(0.5, 0.0, 1.5, self.bounds.height))
//        rightLineView.backgroundColor = UIColor.redColor()
//        contentView.addSubview(rightLineView)
    }
    
    override func drawRect(rect: CGRect) {
        // rows 0-8 and columns 0-8
        // If it is row 2, 5, or 8, draw thicker line below
        // If it is row 0, 3, or 6, draw thicker line above
        
        let row = indexPath.row / 9
        let column = indexPath.row % 9
        
        if row == 4 && column == 4 {
            print("DR boundswidth: ", self.bounds.width)
            print("DR contentview bounds: ", self.contentView.bounds.width)
            print("DR right line view : ", self.rightLineView.bounds)
        }
        
//        let row = indexPath.row / 9
//        let column = indexPath.row % 9
//        
//
//        
//        
//        if column == 8 {
//            let lineView = UIView(frame: CGRectMake(self.bounds.width-2.0, 0.0, 1.5, self.bounds.height))
//            lineView.backgroundColor = UIColor.blackColor()
//            contentView.addSubview(lineView)
//        } else if (column + 1) % 3 == 0 {
//            let lineView = UIView(frame: CGRectMake(self.bounds.width-1.5, 0.0, 1.5, self.bounds.height))
//            lineView.backgroundColor = UIColor.blackColor()
//            contentView.addSubview(lineView)
//        } else if column == 0 {
//            let lineView = UIView(frame: CGRectMake(0.5, 0.0, 1.5, self.bounds.height))
//            lineView.backgroundColor = UIColor.blackColor()
//            contentView.addSubview(lineView)
//        }
//        
//        if row == 8 {
//            let lineView = UIView(frame: CGRectMake(0.0, self.bounds.height-2.0, self.bounds.width, 1.5))
//            lineView.backgroundColor = UIColor.blackColor()
//            contentView.addSubview(lineView)
//        } else if (row + 1) % 3 == 0 {
//            let lineView = UIView(frame: CGRectMake(0.0, self.bounds.height-1.5, self.bounds.width, 1.5))
//            lineView.backgroundColor = UIColor.blackColor()
//            contentView.addSubview(lineView)
//        } else if row == 0 {
//            let lineView = UIView(frame: CGRectMake(0.0, 0.5, self.bounds.width, 1.5))
//            lineView.backgroundColor = UIColor.blackColor()
//            contentView.addSubview(lineView)
//        }
//        
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    override func prepareForReuse() {
        
//        let row = indexPath.row / 9
//        let column = indexPath.row % 9
//        
//        topLineView.hidden = true
//        bottomLineView.hidden = true
//        leftLineView.hidden = true
//        rightLineView.hidden = true
//        
//        if column == 0 {
//            leftLineView.hidden = false
//        } else if (column + 1) % 3 == 0 {
//            rightLineView.hidden = false
//        }
//        
//        if row == 0 {
//            topLineView.hidden = false
//        } else if (row + 1) % 3 == 0 {
//            bottomLineView.hidden = false
//        }
    }
}