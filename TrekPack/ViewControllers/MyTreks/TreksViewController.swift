//
//  TreksTableViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//
import UIKit

class TreksTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate{
    
    var tableView = AutomaticHeightTableView()
    
    var reload = true
    var newReload = false
    
    //Todo: Will contain all the users treks
    let trips:[String] = []

    let cellReuseID = "cell"
    
    override func viewDidAppear(_ animated: Bool) {

    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        checkForTreks()
        tableView.reloadData()
        createCellBackdrop()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imgView.isHidden = true
        noTrekLabel.isHidden = true
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overrideUserInterfaceStyle = .light

        view.viewAddBackground(imgName: "balloon")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.tableFooterView = UIView()
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        setupUI()
        setupNavigationBar()

        
    }
    
    func checkForTreks(){
        

        if (AllTreks.treksArray.isEmpty){
            imgView.isHidden = false
            noTrekLabel.isHidden = false
        }else{
            imgView.isHidden = true
            noTrekLabel.isHidden = true
        }
    }
    
    
    
    @objc func createTrek(){
        
        
        AllTreks.makingNewTrek = true
  
        ///Todo: Change this so it has a proper name!
       let ass = NewTrekVC()
       

       self.presentInFullScreen(ass, animated:true, completion: nil)
      
       print("Adding new trek")
              
        
    }
    
    
   
    func setupUI(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = .zero
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        
        
        //TABLE VIEW
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        
        //NEW TREK BUTTON
        view.addSubview(newTrekButton)
        newTrekButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        newTrekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTrekButton.widthAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
        newTrekButton.heightAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
        
        //NO TREK ICONS
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.width/6).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        
        view.addSubview(noTrekLabel)
        noTrekLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noTrekLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -view.frame.width/6).isActive = true
        noTrekLabel.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        noTrekLabel.widthAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        
    }
    func createCellBackdrop(){
        
        if (AllTreks.treksArray.isEmpty == false){
            for cell in tableView.visibleCells{
                let bgView:UIView = {
                   let view = UIView()
                   view.translatesAutoresizingMaskIntoConstraints = false
                    view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.7)
                   return view
                }()
                
                bgView.frame = CGRect(x: 0, y: 0, width: view.frame.width - view.frame.width/24, height: cell.frame.size.height - cell.frame.size.height/8)
                 bgView.layer.cornerRadius = 10
                 bgView.tag = 1
                 bgView.center = CGPoint(x: cell.bounds.midX, y: cell.bounds.midY)

                cell.contentView.addSubview(bgView)
                cell.contentView.sendSubviewToBack(bgView)
                
                if (cell.contentView.subviews.count > 2){
                    var counter = 0
                    for view in cell.contentView.subviews {
                        if (view.tag == 1){
                            counter += 1
                        }
                    }
                    
                    var temp = -1
                    
                    for view in cell.contentView.subviews.reversed() {
                        
                        if (temp == -1){
                            temp += 1
                        }else if(temp != counter - 1){
                            view.removeFromSuperview()
                            temp += 1
                        }else if (temp == counter - 1){
                            break
                        }
                        
                    }
                }
            }
        }
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.sizeToFit()
        cell.textLabel?.textColor = SingletonStruct.testWhite
        cell.backgroundColor = SingletonStruct.testWhite.withAlphaComponent(0.0)
        cell.selectionStyle = .default
        

        //If there is no return
        if (AllTreks.treksArray[indexPath.row].returnDate.isEmpty){
            cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
            NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont]) +
            NSAttributedString(string: "\n\(AllTreks.treksArray[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }
            
        //Else if there is a return
        else{
            cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
            NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont]) +
                NSAttributedString(string: "\n\(AllTreks.treksArray[indexPath.row].departureDate) - \(AllTreks.treksArray[indexPath.row].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }
         
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        AllTreks.selectedTrek = indexPath.row
        AllTreks.makingNewTrek = false
        SingletonStruct.isViewingPage = true
//        let viewVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VTC")
//        let navController = UINavigationController(rootViewController: viewVC)
//        present(UINavigationController(rootViewController: ViewTrekViewController()), animated: true)
        
//        self.navigationController?.modalPresentationStyle = .fullScreen
        
        
        self.navigationController?.pushViewController(ViewTrekViewController(), animated: true)
//        present(MoreViewController(), animated: true)
//        self.presentInFullScreen(navController, animated:true, completion: nil)
    }
    
    //For deleting from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AllTreks.treksArray.remove(at: indexPath.row)
            SingletonStruct.deleteCellHeight = tableView.cellForRow(at: indexPath)!.frame.height
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            checkForTreks()
        
        }
    }
    
    //UI STUFF
    let imgView:UIImageView = {
        let view = UIImageView()
            view.layer.cornerRadius = 0
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFill
            view.layer.masksToBounds = true
            view.image = UIImage(named: "no_treks")

            view.alpha = 1.0
        return view
    }()
    let noTrekLabel:UILabel = {
        var label = UILabel()
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.attributedText = NSAttributedString(string: "No Treks Found!\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) + NSAttributedString(string: "Add a new trek by tapping the button below", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv2])
            label.textColor = SingletonStruct.testWhite
        return label
    }()
    let newTrekButton:UIButton = {
      let button = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
      button.layer.cornerRadius = 0.5 * button.bounds.size.width
      button.backgroundColor = SingletonStruct.testBlue
      button.layer.borderWidth = 0
      button.addTarget(self, action: #selector(TreksTableViewController.createTrek), for: .touchDown)
      button.translatesAutoresizingMaskIntoConstraints = false
      let plusString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
      let icon = NSTextAttachment()
      icon.image = UIImage(named: "plus")
      icon.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
      let string = NSAttributedString(attachment: icon)
      plusString.append(string)
      button.setAttributedTitle(plusString, for: .normal)

      return button
 }()
    
}


//Code for adding a line underneath the textfield input (idk what it does!!)
enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

//Use to dimiss the keyboard on tap
extension UIViewController {
    
    //Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
