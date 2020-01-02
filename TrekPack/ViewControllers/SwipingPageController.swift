//
//  SwipingPageController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-24.
//  Copyright © 2019 Moktar. All rights reserved.


import UIKit

//Is this even being used at all?! might be able to delete it...
class SwipingPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let newTripPageOne:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTPage1") as UIViewController
      
      let newTripPageTwo:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTPage2") as UIViewController
    
    let navC:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NV1") as! UINavigationController
    
    let navB:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NV2") as! UINavigationController
    
    
    var pages = [Page]()
    
  
    let bottomControlsStackView = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.isPagingEnabled = true
        
        pages = [Page(pageNavController:navC), Page(pageNavController: navB)]
        
        setupBottomControls()
        setupUINavBar()
      
    }
    
    
    //Creating previous button
    private let previousButton:UIButton = {
      let button = UIButton(type: .system)
      button.setTitle("PREV", for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
      button.setTitleColor(.gray, for: .normal)
      button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
      return button
      }()
       
    
    //Function called when the previous button is tapped
    @objc private func handlePrev()
    {
       let nextIndex = max(pageControl.currentPage - 1, 0)
       let indexPath = IndexPath(item: nextIndex, section: 0)
       pageControl.currentPage = nextIndex
       collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    
       checkPage()
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
    
    //Function called when the next button is tapped
    @objc private func handleNext()
    {
        let nextIndex = min(pageControl.currentPage + 1, pages.count-1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    
        checkPage()
    }
    
    //Function that will be called when the Finish button is tapped
    @objc private func handleFinish()
    {
        
    }
    
    //Function called on next/previous button is tapped or collection view is scrolled, will make the "Next" button on the last page into
    //the "Finish" button
    func checkPage(){
        
        
        //If its the last page do this
        if (pageControl.currentPage == pages.count-1){
            
            bottomControlsStackView.removeArrangedSubview(nextButton)
            nextButton.removeFromSuperview()
            bottomControlsStackView.insertArrangedSubview(finishButton, at: 2)
       
        //If its not the last page and the stack view contains the finish button do this
        }else if (pageControl.currentPage != pages.count - 1 && bottomControlsStackView.arrangedSubviews.contains(finishButton)){
           
            bottomControlsStackView.removeArrangedSubview(finishButton)
            finishButton.removeFromSuperview()
            bottomControlsStackView.insertArrangedSubview(nextButton, at: 2)
        }
    }

    //Page control stuff
    lazy var pageControl:UIPageControl =
    {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = ColorStruct.subColor
        pc.pageIndicatorTintColor = .gray
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    //Setting up the bottom controls
    private func setupBottomControls()
       {
        bottomControlsStackView.insertArrangedSubview(previousButton, at: 0)
        bottomControlsStackView.insertArrangedSubview(pageControl, at: 1)
        bottomControlsStackView.insertArrangedSubview(nextButton, at: 2)
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
           
        bottomControlsStackView.distribution = .fillEqually
           
        view.addSubview(bottomControlsStackView)

        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -10),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 40)
           ])
       }
    

    //Creating the finish button
    private let finishButton:UIButton = {
        let button = UIButton()
        button.setTitle("FINISH", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(ColorStruct.subColor, for: .normal)
        button.addTarget(self, action: #selector(SwipingPageController.handleFinish), for: .touchUpInside)
        return button
    }()
     
    //Called to setup the nav bar in viewDidLoad
    func setupUINavBar(){
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(SwipingPageController.cancelSelected))

        self.navigationItem.leftBarButtonItem = cancelBtn
       
        self.navigationController?.navigationBar.barTintColor = ColorStruct.titleColor
        self.navigationController?.navigationBar.tintColor = ColorStruct.backgroundColor
    }
    
    //Called when cancelled nav bar item is tapped
    @objc func cancelSelected(){
        let nextIndex = 0
        let indexPath = IndexPath(item: 0, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        checkPage()
    }
    
    private func setupUI(){
    }   
}

