//
//  PageCell.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-24.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    var page: Page? {
        
        didSet {
            guard let unwrappedPage = page else {return}
            
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
            titleTextView.attributedText = attributedText
            titleTextView.textAlignment = .center
            titleTextView.backgroundColor = .clear
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .brown
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    private func setupUI(){
        addSubview(titleTextView)
        
        titleTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleTextView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
