//
//  NewTrekCollectionVC.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-24.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

class NewTrekCollectionVC: UIViewController, UIScrollViewDelegate,UITextFieldDelegate{
    
    
    var pages:[UIView] = []
    
    var currPage:Int = 0
    
    var newTrekSV = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        self.newTrekSV.contentInsetAdjustmentBehavior = .never
//        view.viewAddBackground(imgName: "sm")
        view.backgroundColor = .black
        newTrekSV.delegate = self
        inputTrekName.delegate = self
        
//        createPages()
        setupLayout()
        
    }
    
    
    
    
    
    
    private func setupLayout(){
   
        newTrekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        newTrekSV.isPagingEnabled = true
        newTrekSV.backgroundColor = .blue
        
        newTrekSV.translatesAutoresizingMaskIntoConstraints = false
        
    
//
        newTrekSV.contentInset = .zero
        newTrekSV.showsVerticalScrollIndicator = false
        newTrekSV.showsHorizontalScrollIndicator = false
        newTrekSV.clipsToBounds = true
        
        
        
        
        


        
        
        

        var frame = CGRect(x: -newTrekSV.frame.width, y: 0, width: 0, height: 0)

        for i in 0...2{

            frame.origin.x += newTrekSV.frame.size.width
            frame.size = newTrekSV.frame.size
            
            
            
            if (i == 0){
                
                let view: UIView = UIView(frame: frame)
            
//                let text = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//                text.translatesAutoresizingMaskIntoConstraints = false
//                text.text = "first view"
//
//                view.addSubview(text)
//                text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//                text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                
                let pageOneMainHeader:UILabel = {
                
                    let label = UILabel()
                    
                    label.textColor = SingletonStruct.titleColor
                    label.backgroundColor = .clear
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .left

                    let labelContent = NSAttributedString(string: "Let's Get Started!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
                    
                    label.attributedText = labelContent
                    return label
                }()
                let pageOneSubHeader:UILabel = {
                
                    let label = UILabel()
                    
                    label.textColor = SingletonStruct.titleColor
                    label.backgroundColor = .clear
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .left
                    label.lineBreakMode = .byWordWrapping
                    label.numberOfLines = 0
                    
                    let labelContent = NSAttributedString(string: "Here is where your Trek begins, start by entering your Treks name below!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
                    
                    label.attributedText = labelContent
                    return label
                }()

                view.backgroundColor = .systemOrange
                view.addSubview(pageOneMainHeader)
                pageOneMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageOneMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageOneMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width/16).isActive = true
                 
                 
                 
                view.addSubview(pageOneSubHeader)
                pageOneSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageOneSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageOneSubHeader.topAnchor.constraint(equalTo: pageOneMainHeader.bottomAnchor).isActive = true
                 
                 
                
               
                view.layer.borderColor = UIColor.green.cgColor
                view.layer.borderWidth = 1
                newTrekSV.addSubview(view)
            }else if (i == 1){
                let view: UIView = UIView(frame: frame)
//                let text = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//                 text.translatesAutoresizingMaskIntoConstraints = false
//                 text.text = "second view"
//
//                 view.addSubview(text)
//                 text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//                 text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                
                let pageOneMainHeader:UILabel = {
                
                    let label = UILabel()
                    
                    label.textColor = SingletonStruct.titleColor
                    label.backgroundColor = .clear
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .left

                    let labelContent = NSAttributedString(string: "Let's Get Started!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
                    
                    label.attributedText = labelContent
                    return label
                }()
                let pageOneSubHeader:UILabel = {
                
                    let label = UILabel()
                    
                    label.textColor = SingletonStruct.titleColor
                    label.backgroundColor = .clear
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .left
                    label.lineBreakMode = .byWordWrapping
                    label.numberOfLines = 0
                    
                    let labelContent = NSAttributedString(string: "Here is where your Trek begins, start by entering your Treks name below!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
                    
                    label.attributedText = labelContent
                    return label
                }()
                
                view.backgroundColor = .systemPink
                view.addSubview(pageOneMainHeader)
                pageOneMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageOneMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageOneMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width/16).isActive = true
                 
                 
                 
                view.addSubview(pageOneSubHeader)
                pageOneSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageOneSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageOneSubHeader.topAnchor.constraint(equalTo: pageOneMainHeader.bottomAnchor).isActive = true
                 
                
                
                 view.layer.borderColor = UIColor.green.cgColor
                 view.layer.borderWidth = 1
                 newTrekSV.addSubview(view)
            }else{
                let view: UIView = UIView(frame: frame)
                let text = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                 text.translatesAutoresizingMaskIntoConstraints = false
                 text.text = "other view"
                
                 view.addSubview(text)
                 text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                 text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                
                
                 view.layer.borderColor = UIColor.green.cgColor
                 view.layer.borderWidth = 1
                 newTrekSV.addSubview(view)
            }
           
            
                
            
           

            
            

         
            


            


       }
        
        newTrekSV.contentSize = CGSize(width: newTrekSV.frame.size.width * 3, height: newTrekSV.frame.size.height)
        
        

    
        view.addSubview(newTrekSV)
        newTrekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTrekSV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newTrekSV.heightAnchor.constraint(equalToConstant: newTrekSV.frame.height).isActive = true
        newTrekSV.widthAnchor.constraint(equalToConstant: newTrekSV.frame.width).isActive = true
        
        
        
        
        
        
        
        
    }
    
    private func createPages(){
        let pageOne:UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            //view.viewAddBackground(imgName: "sm")
            view.backgroundColor = .blue
            
            view.addSubview(pageOneMainHeader)
            pageOneMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            pageOneMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            pageOneMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width/16).isActive = true
            
            
            
            view.addSubview(pageOneSubHeader)
            pageOneSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            pageOneSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            pageOneSubHeader.topAnchor.constraint(equalTo: pageOneMainHeader.bottomAnchor).isActive = true
            
            
            view.addSubview(trekNameLabel)
            trekNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            trekNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            trekNameLabel.topAnchor.constraint(equalTo: pageOneSubHeader.bottomAnchor, constant: view.frame.height/8).isActive = true
            
            
            
            
            
            view.addSubview(backdropLabel)
            backdropLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            backdropLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            backdropLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            backdropLabel.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true

            view.addSubview(inputTrekName)
            inputTrekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            inputTrekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            inputTrekName.heightAnchor.constraint(equalToConstant: 50).isActive = true
            inputTrekName.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true
            
            
            
           
            
            view.addSubview(cancelButton)
            cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
            
            view.addSubview(nextButton)
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
            
            
            
            
            
            
            
            return view
        }()
        let pageTwo:UIView = {
            
            
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
             //view.viewAddBackground(imgName: "sm")
            view.backgroundColor = .black
            view.addSubview(pageOneMainHeader)
            pageOneMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            pageOneMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            pageOneMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width/16).isActive = true
             
             
             
            view.addSubview(pageOneSubHeader)
            pageOneSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            pageOneSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            pageOneSubHeader.topAnchor.constraint(equalTo: pageOneMainHeader.bottomAnchor).isActive = true
             
             
            view.addSubview(trekNameLabel)
            trekNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            trekNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            trekNameLabel.topAnchor.constraint(equalTo: pageOneSubHeader.bottomAnchor, constant: view.frame.height/8).isActive = true
             
             
             
             
             
            view.addSubview(backdropLabel)
            backdropLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            backdropLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            backdropLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            backdropLabel.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true

            view.addSubview(inputTrekName)
            inputTrekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            inputTrekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            inputTrekName.heightAnchor.constraint(equalToConstant: 50).isActive = true
            inputTrekName.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true
            
             
             
            
             
            view.addSubview(cancelButton)
            cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
             
            view.addSubview(nextButton)
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
             
             
             
             
             
             
             
            return view
        }()
        
        let pageThree:UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            view.viewAddBackground(imgName: "sm")
            
            return view
        }()
        
        
        pages.append(pageOne)
        pages.append(pageTwo)
        pages.append(pageThree)
    }
    
    
    
    
    @objc func cancelTrek(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func nextPage(){
        newTrekSV.scrollTo(horizontalPage: currPage+1, verticalPage: 0, animated: true)
    }
    
    @objc func prevPage(){
        newTrekSV.scrollTo(horizontalPage: currPage-1, verticalPage: 0, animated: true)
    }
    
    
    
    
    //BUTTONS
    let cancelButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(NewTrekCollectionVC.cancelTrek), for: .touchDown)
        return button
    }()
    let previousButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Prev", for: .normal)
        button.addTarget(self, action: #selector(NewTrekCollectionVC.prevPage), for: .touchDown)
        return button
    }()
    let nextButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Next", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(NewTrekCollectionVC.nextPage), for: .touchDown)
        return button
    }()
    
    
    //PAGE CONTROL
    let pageControl: UIPageControl = {
       let pc = UIPageControl()
        
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        
        return pc
        
    }()
    
    //PAGE 1 LABELS
    let pageOneMainHeader:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Let's Get Started!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let pageOneSubHeader:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        let labelContent = NSAttributedString(string: "Here is where your Trek begins, start by entering your Treks name below!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        label.attributedText = labelContent
        return label
    }()
    
    
    
    
    
    //TREK NAME
    let trekNameLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "My Treks name is...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel])
        
         label.attributedText = labelContent
        return label
    }()
    let inputTrekName:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.font = SingletonStruct.inputFont
        
        textField.adjustsFontSizeToFitWidth = false
        textField.minimumFontSize = 14
        
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done

        
        
        
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        
        
         textField.attributedPlaceholder = NSAttributedString(string: "Untitled Trek", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .yes
        
        
        
        
      
        
        return textField
    }()
    let backdropLabel:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
   
    
    
    //Setting the number of input characters allowed in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 35
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //Used to dismiss keyboard on "Done" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTrekName.resignFirstResponder()
        return true
    }
    
    
   
}


extension UIScrollView {

    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }

}
