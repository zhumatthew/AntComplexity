//
//  UICollectionViewFlowLayoutSudoku.swift
//  AntComplexity
//
//  Created by Matt Zhu on 4/26/16.
//
//

import Foundation
import UIKit

class UICollectionViewFlowLayoutSudoku: UICollectionViewFlowLayout {
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.bounds.size
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = UICollectionViewLayoutAttributes.init(forCellWithIndexPath: <#T##NSIndexPath#>)
        
        var array = [UICollectionViewLayoutAttributes]()
        
        for i in 0...80 {
            array.append(self.layoutAttributesForItemAtIndexPath(NSIndexPath(forRow: i, inSection: 0))!)
        }
        
        // UICollectionViewLayoutAttributes
        // collectionView.
        return array
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let row = indexPath.row / 9
        let column = indexPath.row % 9
        let cellSize = CGSizeMake(collectionView!.bounds.size.width / 9.0, collectionView!.bounds.size.height / 9.0)
        attributes.frame = CGRectMake(CGFloat(column) * cellSize.width, CGFloat(row) * cellSize.height, cellSize.width, cellSize.height)
        return attributes
//        attributes.frame
    }
    
    
    
    
}