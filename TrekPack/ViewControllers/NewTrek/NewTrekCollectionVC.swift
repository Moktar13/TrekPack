//
//  NewTrekCollectionVC.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-24.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

class NewTrekCollectionVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        setupBottomControls()
        setupLayout()
        
    }
    
    
    private func setupLayout(){
   
        let ass = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        ass.isPagingEnabled = true
        ass.backgroundColor = .lightGray
        
        
        ass.translatesAutoresizingMaskIntoConstraints = false
        ass.showsVerticalScrollIndicator = false
        ass.contentSize.height = 1
        
        let numberOfPages :Int = 4
        let padding : CGFloat = 5
        let viewWidth = ass.frame.size.width
        let viewHeight = ass.frame.size.height
        
        
        
        var x : CGFloat = 0

               for i in 0...numberOfPages{
                    
                    let view: UIView = UIView(frame: CGRect(x: x, y: padding, width: viewWidth, height: viewHeight))
                    var lkk = UILabel()
                    lkk.translatesAutoresizingMaskIntoConstraints = false
                    lkk.text = "asdsad \(i)"
                
                    view.addSubview(lkk)
                    
                    lkk.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                    lkk.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                    
                    view.backgroundColor = UIColor.white
                    ass.addSubview(view)

                    x = view.frame.origin.x + viewWidth + 1
               }
        
//        ass.contentSize = CGSize(width: x+padding, height:view.frame.height)
        ass.contentSize = CGSize(width: x, height: 1.0)
       

        view.addSubview(ass)
        ass.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ass.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        ass.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        ass.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
//        ass.widthAnchor.constraint(equalToConstant: view..width).isActive = true
//        ass.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        
        
        
        
        
    }
    //Might not need this?
    private func setupBottomControls(){
        view.addSubview(previousButton)
        previousButton.backgroundColor = .lightGray
        previousButton.setTitleColor(.black, for: .normal)
        previousButton.setTitle("Prev", for: .normal)
        
        previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/14).isActive = true
        previousButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/8).isActive = true
        
        
        view.addSubview(nextButton)
        nextButton.backgroundColor = .lightGray
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        
        nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/14).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/8).isActive = true
        
        
        view.addSubview(pageControl)
        pageControl.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: view.frame.width/14).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -view.frame.width/14).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/8).isActive = true
        
        
    }
    
    let previousButton:UIButton = {
       
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    let nextButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    let pageControl: UIPageControl = {
       let pc = UIPageControl()
        
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        
        return pc
        
    }()
    
    
    let scrollView:UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .black
//        scrollView.layer.borderColor = UIColor.black.cgColor
        
        
        let numberOfPages :Int = 4
        let padding : CGFloat = 5
        let viewWidth = scrollView.frame.size.width - 2 * padding
        let viewHeight = scrollView.frame.size.height - 2 * padding
//
//        var x : CGFloat = 0
//
//        for i in 0...numberOfPages{
//            let view: UIView = UIView(frame: CGRect(x: x, y: padding, width: viewWidth, height: viewHeight))
//            view.backgroundColor = UIColor.white
//            scrollView .addSubview(view)
//
//            x = view.frame.origin.x + viewWidth + padding
//        }
//
//        scrollView.contentSize = CGSize(width:x+padding, height:scrollView.frame.size.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
        
        
    }()
}
