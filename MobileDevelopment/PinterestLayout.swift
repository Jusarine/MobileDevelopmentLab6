//
//  PinterestLayout.swift
//  MobileDevelopment
//
//  Created by Tatyana May on 12/6/20.
//  Copyright © 2020 Tatyana Gladka. All rights reserved.
//

import Foundation
import UIKit

class PinterestLayout: UICollectionViewLayout {
    
    private let numberOfColumns = 4
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        
        let columns = [0, 1, 3, 0, 3, 0, 2, 3, 2, 3]
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var yOffset: [CGFloat] = [CGFloat](repeating: 0, count: numberOfColumns)
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let column = columns[item % 10]
            
            let widthCoef = item % 10 == 1 || item % 10 == 5 ? 2 : 1
            let width = columnWidth * CGFloat(widthCoef)
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: width)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: item, section: 0))
            attributes.frame = frame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            
            for i in 0..<widthCoef {
                 yOffset[column + i] = yOffset[column + i] + width
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }
    
}
