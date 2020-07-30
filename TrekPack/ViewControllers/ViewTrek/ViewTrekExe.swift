//
//  ViewTrekExe.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-27.
//  Copyright © 2020 Moktar. All rights reserved.
//


import UIKit

extension ViewTrekViewController{
    
    //MARK: setupScreen
    func setupScreen(){
        
        //img view
        view.addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        //white space
        view.addSubview(whiteSpaceView)
        whiteSpaceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2 - view.frame.height/8.5).isActive = true
        whiteSpaceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteSpaceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        whiteSpaceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        imgView.bottomAnchor.constraint(equalTo:whiteSpaceView.centerYAnchor, constant:0 ).isActive = true
    
        buttonStackView.addArrangedSubview(trekInfoBtn)
        buttonStackView.addArrangedSubview(trekItemsBtn)
        buttonStackView.addArrangedSubview(trekRouteBtn)
        
        //Button stack view
        view.addSubview(buttonStackView)
        buttonStackView.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 25).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/6).isActive = true
        

        //scroll view
        trekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2 + view.frame.height/12))
        trekSV.isPagingEnabled = true
        trekSV.backgroundColor = .clear
        trekSV.isScrollEnabled = false
        trekSV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trekSV)
        trekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trekSV.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor).isActive = true
        trekSV.heightAnchor.constraint(equalToConstant: trekSV.frame.height).isActive = true
        trekSV.widthAnchor.constraint(equalToConstant: trekSV.frame.width).isActive = true
       
       }
    
    
    //MARK: setupTableView
    func setupTableView(){
        itemsTableView.register(ItemCell.self, forCellReuseIdentifier: cellReuseID)
        itemsTableView.tableFooterView = UIView()
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.separatorColor = SingletonStruct.testBlue
        itemsTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        itemsTableView.layoutMargins = .zero
        itemsTableView.preservesSuperviewLayoutMargins = false
        itemsTableView.layer.borderColor = SingletonStruct.testBlue.cgColor
        itemsTableView.layer.cornerRadius = 0
        itemsTableView.layer.borderWidth = 0
        itemsTableView.contentInsetAdjustmentBehavior = .never
        itemsTableView.backgroundColor = SingletonStruct.testWhite
        itemsTableView.alwaysBounceHorizontal = false
        itemsTableView.showsVerticalScrollIndicator = false
//        itemsTableView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
    }
    
    
    //MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //MARK: numberOfRows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray[AllTreks.selectedTrek].items.count
    }
    
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) as! ItemCell
        
        cell.itemName.attributedText = NSMutableAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].items[indexPath.row], attributes: [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
        
        
        cell.checkButton.tag = indexPath.row
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.zero
        
        cell.awakeFromNib()
        
        return cell
               
    }
}


//MARK: itemCell
class ItemCell: UITableViewCell {
    
    var row = 0
    
    var isCrossed = false
    
    var itemNameString = ""
    
    let itemName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = false
        label.backgroundColor = .clear
        label.textColor = SingletonStruct.titleColor
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let checkButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "not_checked"), for: .normal)
        return button
    }()
    
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let itemTag = checkButton.tag
        
        if (AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag] == true){
            let attributedString = NSMutableAttributedString(string: itemName.text!, attributes: [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
            
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1.5, range: NSMakeRange(0, attributedString.length))
            
            itemName.attributedText =  attributedString
            
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
        }else{
            let attributedString = NSMutableAttributedString(string: itemName.text!, attributes: [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
            
            itemName.attributedText =  attributedString
            
            checkButton.setImage(UIImage(named: "not_checked"), for: .normal)
        }
        
    }
    
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupUI
    private func setupUI(){
        backgroundColor = .clear
        
        checkButton.addTarget(self, action: #selector(crossItem(sender:)), for: .touchDown)
    }
    
    //MARK: setupConstraints
    private func setupConstraints(){
        addSubview(checkButton)
        checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        addSubview(itemName)
        itemName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        itemName.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor).isActive = true
        itemName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        checkButton.centerYAnchor.constraint(equalTo: itemName.centerYAnchor).isActive = true
    }
    
    
    //MARK: crossItem
    @objc func crossItem(sender: UIButton){
        
        let itemTag = sender.tag
        
        
        
        AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag] = !AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag]
        
        print("CROSSED: \(AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag])")
        
        if (AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag] == true){
            
            let attributedString = NSMutableAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].items[itemTag], attributes: [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1.5, range: NSMakeRange(0, attributedString.length))
            
            itemName.attributedText =  attributedString
            
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
            
        }else{
            
            let attributedString = NSMutableAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].items[itemTag], attributes: [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

            itemName.attributedText =  attributedString
            
            checkButton.setImage(UIImage(named: "not_checked"), for: .normal)
        }
    }
}
