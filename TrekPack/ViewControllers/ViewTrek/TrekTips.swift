//
//  TrekTips.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-07-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

//Class which represents a view controller that informs the user on basic information on the country their visiting
class TrekTips: UIViewController {

    var isConnected = false

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SingletonStruct.testWhite
        
        //Checking if there is a connection and set the boolean accordingly
        if Reachability.isConnectedToNetwork(){
            isConnected = true
        }else{
            isConnected = false
        }
        setupUI()
    }
    
    //MARK: setupUI
    private func setupUI(){
        
        //Checking if there is a connection and then setting the UI accordingly
        if (!isConnected){
            setupNoConnectionUI()
        }else{
            getCountryData()
            setupConnectionUI()
        }
    }
    
    //MARK: setupConnectionUI
    private func setupConnectionUI(){
    
        //NSLayoutConstraint for reconnectTitle
        view.addSubview(reconnectTitle)
        reconnectTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reconnectTitle.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        reconnectTitle.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        
        //NSLayoutConstraint for reconnectSubtitle
        view.addSubview(reconnectSubtitle)
        reconnectSubtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reconnectSubtitle.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        reconnectSubtitle.widthAnchor.constraint(equalToConstant: view.frame.width - 100).isActive = true
        
        //NSLayoutConstraint for reconnectButton
        view.addSubview(reconnectButton)
        reconnectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reconnectButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        reconnectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        reconnectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        
        //NSLayoutConstraint for tipsTitle
        view.addSubview(tipsTitle)
        tipsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        tipsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //NSLayoutConstraint for tipsSubtitle
        view.addSubview(tipsSubtitle)
        tipsSubtitle.topAnchor.constraint(equalTo: tipsTitle.bottomAnchor, constant: 5).isActive = true
        tipsSubtitle.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        tipsSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        //NSLayoutConstraint for spinner
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.startAnimating()
        
        //master stack
        masterStack.addArrangedSubview(capStack)
        masterStack.addArrangedSubview(popStack)
        masterStack.addArrangedSubview(zoneStack)
        masterStack.addArrangedSubview(currencyStack)
        masterStack.addArrangedSubview(languageStack)
        view.addSubview(masterStack)
        masterStack.topAnchor.constraint(equalTo: tipsSubtitle.bottomAnchor, constant: 20).isActive = true
        masterStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height/12).isActive = true
        masterStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        masterStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        
        //cap stack
        capStack.addArrangedSubview(capitalView)
        capStack.addArrangedSubview(capitalLabel)
        capStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        capStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        capStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        capitalView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        capitalView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        capitalLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        //pop stack
        popStack.addArrangedSubview(populationView)
        popStack.addArrangedSubview(populationLabel)
        popStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        popStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        popStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        populationView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        populationView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        populationLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        //zone stack
        zoneStack.addSubview(zoneView)
        zoneStack.addSubview(zoneLabel)
        zoneStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        zoneStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        zoneStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        zoneView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        zoneView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        zoneLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        zoneLabel.leadingAnchor.constraint(equalTo: zoneView.trailingAnchor,constant: 5).isActive = true
        zoneLabel.widthAnchor.constraint(equalTo: populationLabel.widthAnchor).isActive = true
        
        //currency stack
        currencyStack.addArrangedSubview(currencyView)
        currencyStack.addArrangedSubview(currencyLabel)
        currencyStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        currencyStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        currencyStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        currencyView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        currencyView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        currencyLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        //language stack
        languageStack.addArrangedSubview(languageView)
        languageStack.addArrangedSubview(languageLabel)
        languageStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        languageStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        languageStack.heightAnchor.constraint(equalToConstant: 75).isActive = true
        languageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        languageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        languageLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
    }
    
    //MARK: setupNoConnection
    private func setupNoConnectionUI(){
        
        //Setting the UI if there is no connection
        let imgView = UIImageView(image: UIImage(named: "wifi-off"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = NSAttributedString(string: "Oops!", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
    
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let subTitleLabel = UILabel()
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.attributedText = NSAttributedString(string: "It looks like you lost internet connection\nPlease reconnect and try again", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv2, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        view.addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
    }
    
    //MARK: getCountryData
    func getCountryData() {
        
        //hiding UI until all data is ready or there was some other error
        tipsTitle.isHidden = true
        tipsSubtitle.isHidden = true
        reconnectTitle.isHidden = true
        reconnectSubtitle.isHidden = true
        reconnectButton.isHidden = true
        reconnectButton.isEnabled = false
    
        //URL to which the HttpRequest is sent
        let urlString = "https://restcountries.eu/rest/v2/alpha/\(AllTreks.allTreks[AllTreks.selectedTrek].countryISO)"
        let url = URL(string: urlString)
        
        
        print("URL: \(urlString)")
    
        //Creating a URLSession
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            //If there is an error, show the appropriate UI
            if let error = error {
                print("Error: \(error.localizedDescription)")
                
                //Running async on the main thread
                DispatchQueue.main.async {
                    self.reconnectTitle.isHidden = false
                    self.reconnectSubtitle.isHidden = false
                    self.reconnectButton.isHidden = false
                    self.reconnectButton.isEnabled = true
                    self.spinner.stopAnimating()
                }
            
                return
            }
            
            //Getting the httpResponse
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                                        
                    //If the httpReponse code isn't in the 200's then some error occured, run this UI code on the main thread
                    DispatchQueue.main.async {
                        self.reconnectTitle.isHidden = false
                        self.reconnectSubtitle.isHidden = false
                        self.reconnectButton.isHidden = false
                        self.reconnectButton.isEnabled = true
                        self.spinner.stopAnimating()
                    }
                return
            }
            

            if let data = data{
                
                //Decoding the received JSON
                let decoder = JSONDecoder()
                
                if let country = try? decoder.decode(Country.self, from: data) {
                    
                    var popArr = [String]()
                    
                    //Dissecting the country population into an array of strings (each element is one character)
                    for char in String(country.population) {
                        popArr.append(String(char))
                    }
                    
                    //Used to determine where to set the commas for the population
                    if (popArr.count == 4){
                        popArr[0] += ","
                    }
                    
                    if (popArr.count == 5){
                        popArr[1] += ","
                    }
                    
                    if (popArr.count == 6){
                        popArr[2] += ","
                    }
                    
                    if (popArr.count == 7){
                        popArr[0] += ","
                        popArr[3] += ","
                    }
                    
                    if (popArr.count == 8){
                        popArr[1] += ","
                        popArr[4] += ","
                    }
                    
                    if (popArr.count == 9){
                        popArr[2] += ","
                        popArr[5] += ","
                    }
                    
                    if (popArr.count == 10){
                        popArr[0] += ","
                        popArr[3] += ","
                        popArr[6] += ","
                    }
                    
                    if (popArr.count == 11){
                        popArr[1] += ","
                        popArr[4] += ","
                        popArr[7] += ","
                    }
                    
                    if (popArr.count == 12){
                        popArr[2] += ","
                        popArr[5] += ","
                        popArr[8] += ","
                    }
                    
                    if (popArr.count == 13){
                        popArr[3] += ","
                        popArr[6] += ","
                        popArr[9] += ","
                    }
                    
                    //Turning the array into a string
                    var popString = ""
                    for char in popArr {
                        popString += char
                    }
                    
                    DispatchQueue.main.async {
                    
                        //Hiding and disabling certain UI
                        self.tipsTitle.isHidden = false
                        self.tipsSubtitle.isHidden = false
                        self.spinner.stopAnimating()
                        self.masterStack.isHidden = false
                        
                        //Setting UI values which would represent the tips
                        self.capitalLabel.attributedText = NSAttributedString(string: country.capital, attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
                        self.populationLabel.attributedText = NSAttributedString(string: popString, attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
                        self.currencyLabel.attributedText = NSAttributedString(string: "\(country.currencies[0].symbol) \(country.currencies[0].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
                        self.languageLabel.attributedText = NSAttributedString(string: "\(country.languages[0].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
                        
                        
                        //Creating date formatter to set the desired settings for the time zone value
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "h:mm a"
                        dateFormatter.amSymbol = "AM"
                        dateFormatter.pmSymbol = "PM"
                        let timeZone = TimeZone(identifier: "\(AllTreks.allTreks[AllTreks.selectedTrek].timeZone)")
                        dateFormatter.timeZone = timeZone

                        
                        //Setting the zone and the tips subtitle UI
                        self.zoneLabel.attributedText = NSAttributedString(string: "\(AllTreks.allTreks[AllTreks.selectedTrek].timeZone) \(dateFormatter.string(from: Date()))", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])

                        self.tipsSubtitle.attributedText = NSAttributedString(string: "Showing trek tips for \(country.name).", attributes: [NSAttributedString.Key.font: SingletonStruct.tipSubtitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
                    }
                }else{
                    print("Error Decoding")
                }
            }else{
                print("Error")
            }
        }
        task.resume()
    }
    
    //MARK: attemptReconnect
    @objc func attemptReconnect(){
        print("Attemting to reconnect")
        getCountryData()
    }
    
    //MARK: UI Declarations
    let tipsTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Trek Tips", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let tipsSubtitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Showing trek tips", attributes: [NSAttributedString.Key.font: SingletonStruct.tipSubtitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let capitalView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cap")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let capitalLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Capital", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let capStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    let populationView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pop")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let populationLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Population", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let popStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    

    let zoneView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "zone")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let zoneLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Time Zone", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let zoneStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    

    let currencyView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mon")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let currencyLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.60
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Currency", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let currencyStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    let languageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "lang")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let languageLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Language", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let languageStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    let masterStack:UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    let spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = SingletonStruct.testBlue
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let reconnectTitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.contentMode = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Oops!", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let reconnectSubtitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.contentMode = .center
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Looks like there was a problem...", attributes: [NSAttributedString.Key.font: SingletonStruct.tipSubtitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        return label
    }()
    
    let reconnectButton:UIButton = {
        let button = UIButton()
        let titleString = NSAttributedString(string: "Try Again", attributes: [NSAttributedString.Key.font: SingletonStruct.tipSubtitleFont])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(titleString, for: .normal)
        button.addTarget(self, action: #selector(TrekTips.attemptReconnect), for: .touchDown)
        button.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.75)
        button.layer.cornerRadius = 25
        return button
    }()
}
