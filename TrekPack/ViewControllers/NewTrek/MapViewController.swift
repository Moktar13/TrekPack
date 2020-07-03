//
//  MapViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-29.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import MapKit

///Todo: Add functionality which shows cool things to do at the selected location

//MARK: Class declaration
class MapViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var places = [MKMapItem]()
    var locationIndicator = [Int]()
    
    var locationValueIndicator = 0
    
    let navBar = UINavigationBar()
    let searchBar = UISearchBar()
    let searchRequest = MKLocalSearch.Request()
    
    let cellID = "cellID"
    
    let tableView = UITableView()
    
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: cellID)
        
        setupMap()
        setupNavigationBar()
        setupTableView()
    
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //MARK: Tableview functions
    func setupTableView(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.isUserInteractionEnabled = false
    
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        var streetAddress = "123"
        var streetName = "Abc"
        var city = "city"
        var province = "province"
        var postal = "postal"
        var country = "country"
        
        
        cell.nameLabel.text = places[indexPath.row].name
        
        streetAddress = places[indexPath.row].placemark.subLocality ?? ""
        streetName = places[indexPath.row].placemark.subThoroughfare ?? ""
        city = places[indexPath.row].placemark.subAdministrativeArea ?? ""
        province = places[indexPath.row].placemark.administrativeArea ?? ""
        postal = places[indexPath.row].placemark.postalCode ?? ""
        
        let current = Locale(identifier: "en_US")
        country = current.localizedString(forRegionCode: places[indexPath.row].placemark.countryCode ?? " ") ?? " "
            
        if (locationIndicator[indexPath.row] == 1){
            cell.locationLabel.text = streetAddress + " " + streetName + ", " + city + " " + province + " " + postal + ", " + country
        }else if (locationIndicator[indexPath.row] == 2){
            cell.locationLabel.text = city + " " + province + " " + postal + ", " + country
        }else if (locationIndicator[indexPath.row] == 3){
            cell.locationLabel.text = city + ", " + country
        }else if (locationIndicator[indexPath.row] == 4){
            cell.locationLabel.text = city + ", " + country
        }else if (locationIndicator[indexPath.row] == 5){
            cell.locationLabel.text = province + ", " + country
        }else if (locationIndicator[indexPath.row] == 6){
            cell.locationLabel.text = country
        }else if (locationIndicator[indexPath.row] == 7){
            cell.locationLabel.text = streetName + ", " + city + " " + province + " " + postal + ", " + country
        }
        
        print("LOCATION INFORMATION ----\nLOCATION INDICATOR VALUE: \(locationIndicator[indexPath.row])\nNAME: \(places[indexPath.row].name)\nADDRESS: \(streetAddress)\nSTREET: \(streetName)\nCITY: \(city)\nPROVINCE: \(province)\nPOSTAL: \(postal)\nCOUNTRY: \(country)\n-----")
        
        
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    //MARK: Setup Map
    private func setupMap(){
        let map = MKMapView()
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(map)
        
        map.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        map.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        map.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        map.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    //MARK: Setup Navigation Bar
    private func setupNavigationBar(){
        
        let patchView = UIView()
        patchView.translatesAutoresizingMaskIntoConstraints = false
        patchView.backgroundColor = .white
        
        view.addSubview(patchView)
        patchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        patchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        patchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    
        navBar.isTranslucent = false
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .white
        
        view.addSubview(navBar)
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        patchView.bottomAnchor.constraint(equalTo: navBar.topAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "")
        
        let backItem = UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: #selector(MapViewController.cancelMap))
       
        navItem.leftBarButtonItem = backItem
        navItem.titleView = searchBar
        
        navBar.setItems([navItem], animated: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        places.removeAll()
        tableView.reloadData()

        searchRequest.naturalLanguageQuery = searchBar.text
        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                if (self.checkLocation(location: item) && !self.places.contains(item)){
                    self.places.append(item)
                }else{
                    print("Location already saved OR location has some error")
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    //MARK: Check location
    func checkLocation(location: MKMapItem) -> Bool{
        var locationGood = false
        
        let address = location.placemark.subLocality?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let street = location.placemark.subThoroughfare?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let city = location.placemark.subAdministrativeArea?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let province = location.placemark.administrativeArea?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let postal = location.placemark.postalCode?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let country = location.placemark.countryCode?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        //Has everything
        if (!address.isEmpty && !street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
            locationGood = true
            
        //All but address
        }else if (address.isEmpty && !street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
            locationGood = true
        }
            
        
        //city, province, postal, country
        else if (!city.isEmpty && !province.isEmpty && !postal.isEmpty && !country.isEmpty){
            locationGood = true
            
            
        
        }
        //city, province, country
        else if (!city.isEmpty && !province.isEmpty && postal.isEmpty && !country.isEmpty){
            locationGood = true
            
            
        }
            
        //city, country
        else if (!city.isEmpty && province.isEmpty && postal.isEmpty && !country.isEmpty){
            locationGood = true
            
        }
            
        //province, country
        else if (city.isEmpty && !province.isEmpty && postal.isEmpty && !country.isEmpty){
            locationGood = true
            
        }
            
            
        //country
        else if (address.isEmpty && street.isEmpty && city.isEmpty && province.isEmpty && postal.isEmpty && !country.isEmpty){
            locationGood = true
            
            
        }
        
        if (locationGood){
            //Has everything
            if (!address.isEmpty && !street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
                locationIndicator.append(1)
            }
            
            //city, province, postal, country
            else if (!city.isEmpty && !province.isEmpty && !postal.isEmpty && !country.isEmpty){
                locationIndicator.append(2)
                
            
            }
            //city, province, country
            else if (!city.isEmpty && !province.isEmpty && postal.isEmpty && !country.isEmpty){
                
                locationIndicator.append(3)
                
            }
                
            //city, country
            else if (!city.isEmpty && province.isEmpty && postal.isEmpty && !country.isEmpty){
                
                locationIndicator.append(4)
            }
                
            //province, country
            else if (city.isEmpty && !province.isEmpty && postal.isEmpty && !country.isEmpty){
                
                locationIndicator.append(5)
            }
                
                
            //country
            else if (address.isEmpty && street.isEmpty && city.isEmpty && province.isEmpty && postal.isEmpty && !country.isEmpty){
                
                locationIndicator.append(6)
                
            }else if (address.isEmpty && !street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
                locationIndicator.append(6)
            }
        }
        
        return locationGood
        
    }
    


    //MARK: Search
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if (tableView.isHidden){
            tableView.isHidden = false
            tableView.isUserInteractionEnabled = true
            places.removeAll()
            locationIndicator.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        places.removeAll()
        tableView.reloadData()
        
        searchRequest.naturalLanguageQuery = searchBar.text
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                if (self.checkLocation(location: item) && !self.places.contains(item)){
                    self.places.append(item)
                    
                }else{
                    print("Location already saved OR location has some error")
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    
    
    @objc func cancelMap(){
        dismiss(animated: true, completion: nil)
    }
}


//MARK: PlaceCell
class PlaceCell:UITableViewCell {
    
    let nameLabel = UILabel()
    let locationLabel = UILabel()
    
    let destinationIcon:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "map-search-pin")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
        
    }
    
    private func setupUI(){
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = nameLabel.font.withSize(18)
        nameLabel.numberOfLines = 1
        nameLabel.minimumScaleFactor = 0.5
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = locationLabel.font.withSize(15)
        locationLabel.numberOfLines = 1
        locationLabel.minimumScaleFactor = 0.5
        locationLabel.textColor = .lightGray
    }
    
    private func setupConstraints(){
        
        addSubview(destinationIcon)
        destinationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        destinationIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        destinationIcon.heightAnchor.constraint(equalToConstant : frame.height/2).isActive = true
        destinationIcon.widthAnchor.constraint(equalToConstant: frame.height/2).isActive = true
        
        
        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: destinationIcon.trailingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: destinationIcon.centerYAnchor).isActive = true
        
        addSubview(locationLabel)
        locationLabel.leadingAnchor.constraint(equalTo: destinationIcon.trailingAnchor, constant: 5).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: destinationIcon.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
