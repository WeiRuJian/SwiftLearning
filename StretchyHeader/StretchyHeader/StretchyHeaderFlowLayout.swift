//
//  StretchyHeaderFlowLayout.swift
//  StretchyHeader
//
//  Created by WeiRuJian on 2021/1/27.
//

import UIKit

class StretchyHeaderFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?.forEach({ (layoutAttribute) in
            if layoutAttribute.representedElementKind == UICollectionView.elementKindSectionHeader &&
                layoutAttribute.indexPath.section == 0 {
                

                
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY > 0 {
                    return
                }
                let width = collectionView.frame.width
                let height = layoutAttribute.frame.height - contentOffsetY
                
                layoutAttribute.frame = CGRect(x: 0,
                                               y: contentOffsetY,
                                               width: width,
                                               height: height)
            }
        })
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
