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
        
        //adding and setting constraints for imgView
        view.addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        //adding and setting constraints for whiteSpaceView
        view.addSubview(whiteSpaceView)
        whiteSpaceView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -75).isActive = true
        whiteSpaceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteSpaceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        whiteSpaceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        //Setting the bottom anchor for the img to match the centerY anchor of the whitespace view
        imgView.bottomAnchor.constraint(equalTo:whiteSpaceView.topAnchor, constant: 50).isActive = true
    
        //Adding to the buttonStackView
        buttonStackView.addArrangedSubview(trekInfoBtn)
        buttonStackView.addArrangedSubview(trekItemsBtn)
        buttonStackView.addArrangedSubview(trekRouteBtn)
        
        //Adding and setting constraints for buttonStackView
        view.addSubview(buttonStackView)
        buttonStackView.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 25).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/6).isActive = true

        //Adding and setting constraints for the trekSV
        view.addSubview(trekSV)
        trekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trekSV.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor).isActive = true
        trekSV.heightAnchor.constraint(equalToConstant: trekSV.frame.height).isActive = true
        trekSV.widthAnchor.constraint(equalToConstant: trekSV.frame.width).isActive = true
       }
    

    //MARK: setupTableView
    func setupTableView(){
       
        //itemsTableView settings
        itemsTableView.register(ItemCell.self, forCellReuseIdentifier: cellReuseID)
        itemsTableView.tableFooterView = UIView()
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.separatorColor = SingletonStruct.testBlue
        itemsTableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        itemsTableView.layoutMargins = .zero
        itemsTableView.preservesSuperviewLayoutMargins = false
        itemsTableView.layer.borderColor = SingletonStruct.testBlue.cgColor
        itemsTableView.layer.cornerRadius = 10
        itemsTableView.layer.borderWidth = 2
        itemsTableView.contentInsetAdjustmentBehavior = .never
        itemsTableView.backgroundColor = .clear
        itemsTableView.alwaysBounceHorizontal = false
        itemsTableView.showsVerticalScrollIndicator = false
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
        
        //Cell settings
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
            
    //ItemCell UI declarations
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
        
        //Determing if the cell has been checked or not and will set UI accordingly
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
        backgroundColor = .white
        checkButton.addTarget(self, action: #selector(crossItem(sender:)), for: .touchDown)
    }
    
    //MARK: setupConstraints
    private func setupConstraints(){
        //Adding and setting constraints for the checkButton
        addSubview(checkButton)
        checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
        //Adding and setting constraints for the itemName
        addSubview(itemName)
        itemName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        itemName.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor).isActive = true
        itemName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
    //MARK: crossItem
    @objc func crossItem(sender: UIButton){
        
        let itemTag = sender.tag
        
        
        //Setting the cross value to the opposite of what it is
        AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag] = !AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag]
            
        //If the cross is now on, then change the text and button UI accordingly
        if (AllTreks.treksArray[AllTreks.selectedTrek].crosses[itemTag] == true){
            
            let attributedString = NSMutableAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].items[itemTag], attributes: [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1.5, range: NSMakeRange(0, attributedString.length))
            
            itemName.attributedText =  attributedString
            
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
            
        //If the cross is off change the text and button UI accordingly
        }else{
            let attributedString = NSMutableAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].items[itemTag], attributes: [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

            itemName.attributedText =  attributedString
            checkButton.setImage(UIImage(named: "not_checked"), for: .normal)
        }
        
        //Saving it to the device
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(AllTreks.treksArray), forKey: "saved")
    }
}
