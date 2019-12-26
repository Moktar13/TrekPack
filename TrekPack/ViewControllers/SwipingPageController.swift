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
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = ColorStruct.backgroundColor
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.isPagingEnabled = true
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ButtonName", style: .done, target: self, action: #selector(SwipingPageController.cancelSelected))
        
        setupBottomControls()
        setupUINavBar()
    }
    
    //For cancel button
    private let cancelButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleCancel(){
        let nextIndex = 0
        let indexPath = IndexPath(item: 0, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //For previous button
    private let previousButton:UIButton = {
      let button = UIButton(type: .system)
      button.setTitle("PREV", for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
      button.setTitleColor(.gray, for: .normal)
      button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
      return button
      }()
       
   @objc private func handlePrev()
   {
       let nextIndex = max(pageControl.currentPage - 1, 0)
       let indexPath = IndexPath(item: nextIndex, section: 0)
       pageControl.currentPage = nextIndex
       collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
   }
   
    //For next button
    private let nextButton:UIButton = {
      let button = UIButton(type: .system)
      button.setTitle("NEXT", for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
      button.setTitleColor(.black, for: .normal)
      button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
   
      return button
      }()
      
   @objc private func handleNext()
   {
       
        let nextIndex = min(pageControl.currentPage + 1, pages.count-1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
   }


     lazy var pageControl:UIPageControl =
    {
        
        let pc = UIPageControl()
        //pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = ColorStruct.titleColor
        pc.pageIndicatorTintColor = .gray
        return pc
    }()

    fileprivate func setupBottomControls()
       {
          
           let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton,pageControl, nextButton])
           bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
           
            
           bottomControlsStackView.distribution = .fillProportionally
           
           view.addSubview(bottomControlsStackView)
    
           NSLayoutConstraint.activate([
               bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
               bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -10),
               bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
               bottomControlsStackView.heightAnchor.constraint(equalToConstant: 40)
           ])
       }
    
    
   /* fileprivate func setupTopControls()
    {
        let topControlsStackView = UIStackView(arrangedSubviews: [cancelButton])
        topControlsStackView.translatesAutoresizingMaskIntoConstraints = false
    
        topControlsStackView.distribution = .fillEqually
        
        view.addSubview(topControlsStackView)
        

        topControlsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        //topControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        topControlsStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }*/
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    private let finishButton:UIButton = {
        let button = UIButton()
        button.setTitle("FINISH", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    func setupUINavBar(){
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(SwipingPageController.cancelSelected))

        self.navigationItem.leftBarButtonItem = cancelBtn
       
        self.navigationController?.navigationBar.barTintColor = ColorStruct.titleColor
        self.navigationController?.navigationBar.tintColor = ColorStruct.backgroundColor
    }
    
    @objc func cancelSelected(){
        let nextIndex = 0
        let indexPath = IndexPath(item: 0, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
   
}

