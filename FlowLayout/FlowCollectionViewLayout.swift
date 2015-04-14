//
//  FlowCollectionViewLayout.swift
//  FlowLayout
//
//  Created by Tran Thien Khiem on 4/14/15.
//  Copyright (c) 2015 Tran Thien Khiem. All rights reserved.
//

import UIKit

// get rows
protocol FlowCollectionViewLayoutDelegate {
    
    // get size for each row
    func sizeForCellAtIndexPath(indexPath: NSIndexPath) -> CGSize;
    
}

@IBDesignable
class FlowCollectionViewLayout: UICollectionViewLayout {
    
    
    // columns
    @IBInspectable var columns: Int = 2
    
    // padding for each rows
    @IBInspectable var padding: CGFloat = 10.0
    
    var contentSize: CGSize!
    
    // height of columns
    var columnWidth: CGFloat!
    
    // max height on each columns
    var maxHeights: [CGFloat]!
    
    // delegate for flow layout
    var delegate: FlowCollectionViewLayoutDelegate!
    
    // var cg rect
    var attributes: [NSIndexPath: UICollectionViewLayoutAttributes]!
    
    var maxHeight: CGFloat {
        get {
            var result = maxHeights[0]
            
            for var i = 1; i < columns; i++ {
                if result < maxHeights[i] {
                    result = maxHeights[i]
                }
            }
            
            return result
        }
    }
    
    // prepare all layout
    override func prepareLayout() {
        
        if let collectionView = self.collectionView {
            
            // calculate view width
            var width = collectionView.frame.width
            
            // calculate column width
            columnWidth = (width - CGFloat(columns + 1) * padding) / CGFloat(columns)
            
            // initialize all max heights => 0
            maxHeights = [CGFloat](count: columns, repeatedValue: 0.0)
            
            // init all cell frames
            attributes = [NSIndexPath: UICollectionViewLayoutAttributes]()
            
            for var section = 0; section < collectionView.numberOfSections(); section++ {
                for var row = 0; row < collectionView.numberOfItemsInSection(section); row++ {
                    var indexPath = NSIndexPath(forRow: row, inSection: section)
                    attributes[indexPath] = attributeForIndexPath(indexPath)
                }
                
                // end of session reset max height
                maxHeights = [CGFloat](count: columns, repeatedValue: maxHeight + padding)
            }
            
            // set content size
            contentSize = CGSizeMake(width, maxHeight + padding)
        }
        
    }
    
    // layout attributes for elements in rect
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for (indexPath, attribute) in attributes {
            if attribute.frame.intersects(rect) {
                layoutAttributes.append(attribute)
            }
        }
    
        return layoutAttributes
    }
    
    // collection view content size
    override func collectionViewContentSize() -> CGSize {
        return contentSize
    }
    
    // layout attributes for index path
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return attributes[indexPath]
    }
    
    
    // get frame for index path
    func attributeForIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        let size = delegate.sizeForCellAtIndexPath(indexPath)
        
        println("Image size: \(size)")
        // resize and keep ratio
        let height = size.height * columnWidth / size.width
        
        var column = 0
        var y: CGFloat = maxHeights[column]
        
        // find the column with min height
        for var i = 1; i < columns; i++ {
            if maxHeights[i] < y {
                column = i
                y = maxHeights[i]
            }
        }
        
        
        // increase max heights for that folder
        maxHeights[column] += height + padding
        
        let frame = CGRectMake(CGFloat(column) * columnWidth + CGFloat(column + 1) * padding, y + padding, columnWidth, height)
        
        // convert to attribute
        var attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attribute.frame = frame
        
        return attribute
    }
   
}
