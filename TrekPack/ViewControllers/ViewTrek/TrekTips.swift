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
        
        view.addSubview(capitalView)
        capitalView.topAnchor.constraint(equalTo: tipsTitle.bottomAnchor, constant: 25).isActive = true
        capitalView.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        capitalView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        capitalView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        view.addSubview(populationView)
        populationView.topAnchor.constraint(equalTo: capitalView.bottomAnchor, constant: 25).isActive = true
        populationView.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        populationView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        populationView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        view.addSubview(zoneView)
        zoneView.topAnchor.constraint(equalTo: populationView.bottomAnchor, constant: 25).isActive = true
        zoneView.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        zoneView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        zoneView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        view.addSubview(currencyView)
        currencyView.topAnchor.constraint(equalTo: zoneView.bottomAnchor, constant: 25).isActive = true
        currencyView.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        currencyView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        currencyView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        view.addSubview(languageView)
        languageView.topAnchor.constraint(equalTo: currencyView.bottomAnchor, constant: 25).isActive = true
        languageView.leadingAnchor.constraint(equalTo: tipsTitle.leadingAnchor).isActive = true
        languageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        languageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        
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
    
    let capitalView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cap")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let populationView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pop")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let zoneView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "zone")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let currencyView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mon")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let languageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "lang")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
