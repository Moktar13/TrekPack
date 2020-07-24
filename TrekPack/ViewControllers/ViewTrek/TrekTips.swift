//
//  TrekTips.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-07-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit





class TrekTips: UIViewController {
    
    var names = [Country]()
    
    var isConnected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SingletonStruct.testWhite
        
        if Reachability.isConnectedToNetwork(){
            isConnected = true
        }else{
            isConnected = false
        }
        
        setupUI()
    }
    
    private func setupUI(){
        
        if (!isConnected){
            setupNoConnectionUI()
        }else{
            setupConnectionUI()
            getCountryData()
        }
    }
    
    
    
    
    //MARK: setupConnection
    private func setupConnectionUI(){
        
        view.addSubview(tipsTitle)
        tipsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        tipsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        view.addSubview(tipsSubtitle)
        tipsSubtitle.topAnchor.constraint(equalTo: tipsTitle.bottomAnchor, constant: 5).isActive = true
        tipsSubtitle.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        
        masterStack.addArrangedSubview(capStack)
        masterStack.addArrangedSubview(popStack)
        masterStack.addArrangedSubview(zoneStack)
        masterStack.addArrangedSubview(currencyStack)
        masterStack.addArrangedSubview(languageStack)
        
        view.addSubview(masterStack)
        masterStack.topAnchor.constraint(equalTo: tipsTitle.bottomAnchor, constant: 60).isActive = true
        masterStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        masterStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        masterStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        
        capStack.addArrangedSubview(capitalView)
        capStack.addArrangedSubview(capitalLabel)
        
//        view.addSubview(capStack)
//        capStack.topAnchor.constraint(equalTo: tipsTitle.bottomAnchor, constant: 25).isActive = true
        capStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        capStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        capStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        capitalView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        capitalView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        capitalLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        
        popStack.addArrangedSubview(populationView)
        popStack.addArrangedSubview(populationLabel)
        
    
        popStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        popStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        popStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        populationView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        populationView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        populationLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        zoneStack.addSubview(zoneView)
        zoneStack.addSubview(zoneLabel)
    
        
//        view.addSubview(zoneStack)
//        zoneStack.topAnchor.constraint(equalTo: popStack.bottomAnchor, constant: 25).isActive = true
        zoneStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        zoneStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        zoneStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        zoneView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        zoneView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        zoneLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        zoneLabel.leadingAnchor.constraint(equalTo: zoneView.trailingAnchor,constant: 5).isActive = true


        currencyStack.addArrangedSubview(currencyView)
        currencyStack.addArrangedSubview(currencyLabel)
        
//        view.addSubview(currencyStack)
//        currencyStack.topAnchor.constraint(equalTo: zoneStack.bottomAnchor, constant: 25).isActive = true
        currencyStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        currencyStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        currencyStack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        currencyView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        currencyView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        currencyLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true

        languageStack.addArrangedSubview(languageView)
        languageStack.addArrangedSubview(languageLabel)
        
//        view.addSubview(languageStack)
//        languageStack.topAnchor.constraint(equalTo: currencyView.bottomAnchor, constant: 25).isActive = true
        languageStack.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        languageStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        languageStack.heightAnchor.constraint(equalToConstant: 75).isActive = true
        languageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        languageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        languageLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        
    }
    
    //MARK: setupNoConnection
    private func setupNoConnectionUI(){
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
        let url = URL(string: "https://restcountries.eu/rest/v2/alpha/col")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                ///Todo some error message here
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    ///Todo: some error message here
                return
            }
            if let data = data{
                
                let decoder = JSONDecoder()
                
                if let country = try? decoder.decode(Country.self, from: data) {
                    
                    DispatchQueue.main.async {
                        print("ALL: \(country)")
                    }
                }
                
            }
        }
        task.resume()
    }
    
    let tipsTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Trek Tips", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        return label
    }()
    
    let tipsSubtitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Here are some trek tips", attributes: [NSAttributedString.Key.font: SingletonStruct.tipSubtitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        return label
    }()
    
    //capital stuff
    let capitalView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cap")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let capitalLabel:UILabel = {
        let label = UILabel()
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
    
    //population stuff
    let populationView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pop")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let populationLabel:UILabel = {
        let label = UILabel()
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
    
    
    //timezone stuff
    let zoneView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "zone")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let zoneLabel:UILabel = {
        let label = UILabel()
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
    
    
    
    
    //currency stuff
    let currencyView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mon")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let currencyLabel:UILabel = {
        let label = UILabel()
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
    
    
    
    
    //language stuff
    let languageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "lang")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let languageLabel:UILabel = {
        let label = UILabel()
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    
    
}




//MARK: Junkyard

/////todo: put it in the background thread
//    private func getCountryData(){
//
//
//
//        let url = URL(string:"https://restcountries.eu/rest/v2/alpha/col")!
//
//        if let data  = try? Data(contentsOf: url){
//            let decoder = JSONDecoder()
//
//            if let country = try? decoder.decode(Country.self, from: data) {
//                print("ALL INFORMATION: \(country)")
////                print("NAME: \(country.name)")
////                print("CAPITAL: \(country.capital)")
////                print("POPULATION: \(country.population)")
////                print("TIMEZONE: \(country.timezones[0])")
////                print("CURRENCY: \(country.regionalBlocs)")
////                print("LANGUAGES: \(country.languages)")
//
//            }
//        }
//
//
//
//
//    }
    
