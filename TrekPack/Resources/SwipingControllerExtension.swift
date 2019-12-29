//
//  SwipingControllerExtension.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-24.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

extension SwipingPageController{
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           coordinator.animate(alongsideTransition: { (_) in
               self.collectionViewLayout.invalidateLayout()
               
               if (self.pageControl.currentPage == 0)
               {
                   self.collectionView?.contentOffset = .zero
               }else{
                   let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                   self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
               }
           }) { (_) in
               
           }
       }
    
    //Method used for scrolling gesture
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        checkPage()
    }
}
