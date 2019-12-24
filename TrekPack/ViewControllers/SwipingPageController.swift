//
//  SwipingPageController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-24.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class SwipingPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [Page(title: "Page 1", description: "abc"), Page(title: "Page 2", description: "abc"), Page(title: "Page 3", description: "abc")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.isPagingEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
    }
    

     lazy var pageControl:UIPageControl =
    {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .green
        pc.pageIndicatorTintColor = .gray
        return pc
    }()

    fileprivate func setupBottomControls()
       {
          
           let bottomControlsStackView = UIStackView(arrangedSubviews: [ pageControl])
           bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
           
           bottomControlsStackView.distribution = .fillEqually
           
           view.addSubview(bottomControlsStackView)
           
           //same this as .isActive = true
           NSLayoutConstraint.activate([
               bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
               bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
               bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
               bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
           ])
       }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
   
}

