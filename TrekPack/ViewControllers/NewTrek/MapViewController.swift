//
//  MapViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-29.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import MapKit
import Contacts
import CoreLocation

///Todo: Add functionality which shows cool things to do at the selected location

//MARK: Class declaration
class MapViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    //For map stuff
    var places = [MKMapItem]()
    var locationIndicator = [Int]()
    var selectedName = ""
    var selectedSubtitle = ""
    let map = MKMapView()
    
    
    var hasConnection = false
    
   
    
    var locationValueIndicator = 0
    
    let navBar = UINavigationBar()
    let searchBar = UISearchBar()
    let searchRequest = MKLocalSearch.Request()
    
    let cellID = "cellID"
    let annotationID = "annotationID"
    
    let tableView = UITableView()
    
    
    deinit {
        print("Deinitializing MapViewController")
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            
            hasConnection = true
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchPin))
            gestureRecognizer.delegate = self
            
            map.addGestureRecognizer(gestureRecognizer)
            
            map.delegate = self
            searchBar.searchTextField.font = SingletonStruct.subHeaderFont
            searchBar.placeholder = "Search"
            searchBar.delegate = self
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(PlaceCell.self, forCellReuseIdentifier: cellID)
            
            
            
            setupMap()
            setupNavigationBar()
            setupTableView()
            
        }else{
            print("Internet Connection not Available!")
            hasConnection = false
            setupNoConnectionUI()
            noConnectionNavBar()
            
            
        }
        
        
    
    }
    
    //MARK: touchPin
    @objc func touchPin(gestureRecognizer: UILongPressGestureRecognizer){
        
        var streetNumber = ""
        var streetName = ""
        var subCity = ""
        var city = ""
        var municipality = ""
        var province = ""
        var postal = ""
        var country = ""
        let region = ""
        var ocean = ""
        var coordinate: CLLocationCoordinate2D?



       
        
        let location = gestureRecognizer.location(in: map)
        coordinate = map.convert(location, toCoordinateFrom: map)
        
        if (map.annotations.count != 0){
            map.removeAnnotations(map.annotations)
        }
        

        
        let address = CLGeocoder.init()
        
        address.reverseGeocodeLocation(CLLocation.init(latitude: coordinate!.latitude, longitude:coordinate!.longitude)) { (places, error) in
            
                if let place = places{
                    
                    streetNumber = place[0].subThoroughfare ?? ""
                    streetName = place[0].thoroughfare ?? ""
                    subCity = place[0].subLocality ?? ""
                    city = place[0].locality ?? ""
                    municipality = place[0].subAdministrativeArea ?? ""
                    province = place[0].administrativeArea ?? ""
                    postal = place[0].postalCode ?? ""
                    country = place[0].country ?? ""
                    ocean = place[0].ocean ?? ""

                    
                    //Getting location title
                    if (city != ""){
                        self.selectedName = city
                    }else if (municipality != ""){
                        self.selectedName = municipality
                    }else if (province != ""){
                        self.selectedName = province
                    }else if (country != ""){
                        self.selectedName = country
                    }else {
                        self.selectedName = ocean
                    }
                    
                    
                    //Has everything
                    if (!streetNumber.isEmpty && !streetName.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
                        
                        self.selectedSubtitle = streetNumber + " " + streetName + ", " + city + " " + province + " " + postal + ", " + country
                        
                        
                    //All but address
                    }else if (!streetName.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
                        self.selectedSubtitle = streetName + ", " + city + " " + province + " " + postal + ", " + country
                    }
                        
                    
                    //city, province, postal, country
                    else if (!city.isEmpty && !province.isEmpty && !postal.isEmpty){
                        self.selectedSubtitle = city + " " + province + " " + postal + ", " + country
                    }
                    //city, province, country
                    else if (!city.isEmpty && !province.isEmpty){
                        self.selectedSubtitle = city + " " + province + ", " + country
                    }
                        
                    //city, country
                    else if (!city.isEmpty){
                        self.selectedSubtitle = city + ", " + country
                        
                    }
                        
                    //province, country
                    else if (!province.isEmpty){
                        self.selectedSubtitle = province + ", " + country
                    }
                        
                    //country
                    else if (!country.isEmpty){
                        self.selectedSubtitle = country
                        
                    //ocean
                    }else{
                        self.selectedSubtitle = ocean
                    }
                    
                    
                    let selectedPlacemark = PlacemarkAnnotation(title: "", info: "def",streetNumber: streetNumber, streetName: streetNumber, subCity: subCity, city: city, municipality: municipality, province: province, postal: postal, country: country, region: region, ocean: ocean, coordinate: coordinate!)
                    
                    //Assigning the value of the location to the values in TrekStruct
                    AllTreks.treksArray[AllTreks.treksArray.count-1].streetName = streetName
                    AllTreks.treksArray[AllTreks.treksArray.count-1].streetNumber = streetNumber
                    AllTreks.treksArray[AllTreks.treksArray.count-1].subCity = subCity
                    AllTreks.treksArray[AllTreks.treksArray.count-1].city = city
                    AllTreks.treksArray[AllTreks.treksArray.count-1].municipality = municipality
                    AllTreks.treksArray[AllTreks.treksArray.count-1].province = province
                    AllTreks.treksArray[AllTreks.treksArray.count-1].postal = postal
                    AllTreks.treksArray[AllTreks.treksArray.count-1].region = region
                    AllTreks.treksArray[AllTreks.treksArray.count-1].ocean = ocean
                    AllTreks.treksArray[AllTreks.treksArray.count-1].country = country
                    AllTreks.treksArray[AllTreks.treksArray.count-1].latitude = coordinate!.latitude
                    AllTreks.treksArray[AllTreks.treksArray.count-1].longitude = coordinate!.longitude
                    
                    
                    
                    self.map.addAnnotation(selectedPlacemark)
                    self.map.setCenter(selectedPlacemark.coordinate, animated: true)
                    
              
                }else{
                    print("Something went wrong...")
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        map.selectAnnotation(map.annotations[0], animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //MARK: Setup TableView
    func setupTableView(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.isUserInteractionEnabled = false
    
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0.25).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        var streetNumber = ""
        var streetName = ""
        var subCity = ""
        var city = ""
        var municipality = ""
        var province = ""
        var postal = ""
        var country = ""
        var region = ""
        var ocean = ""
        var coordinate: CLLocationCoordinate2D?
        
        
        cell.nameLabel.text = places[indexPath.row].name
        
        streetNumber = places[indexPath.row].placemark.subThoroughfare ?? ""
        streetName = places[indexPath.row].placemark.thoroughfare ?? ""
        subCity = places[indexPath.row].placemark.subLocality ?? ""
        city = places[indexPath.row].placemark.locality ?? ""
        municipality = places[indexPath.row].placemark.subAdministrativeArea ?? ""
        province = places[indexPath.row].placemark.administrativeArea ?? ""
        postal = places[indexPath.row].placemark.postalCode ?? ""
        country = places[indexPath.row].placemark.country ?? ""
        ocean = places[indexPath.row].placemark.ocean ?? ""
        coordinate = places[indexPath.row].placemark.coordinate
        

        
        let current = Locale(identifier: "en_US")
        country = current.localizedString(forRegionCode: places[indexPath.row].placemark.countryCode ?? "") ?? ""
            
        //Has all
        if (locationIndicator[indexPath.row] == 1){
            cell.locationLabel.text = streetNumber + " " + streetName + ", " + city + " " + province + " " + postal + ", " + country
            
        //All but address
        }else if (locationIndicator[indexPath.row] == 2){
            cell.locationLabel.text = streetName + ", " + city + " " + province + " " + postal + ", " + country
        
        //Has city, province, postal, country
        }else if (locationIndicator[indexPath.row] == 3){
            cell.locationLabel.text = city + " " + province + " " + postal + ", " + country
            
        //Has city, province, country
        }else if (locationIndicator[indexPath.row] == 4){
            cell.locationLabel.text = city + " " + province +  ", " + country
            
        //Has city, country
        }else if (locationIndicator[indexPath.row] == 5){
            cell.locationLabel.text = city + ", " + country
            
        //Has province, country
        }else if (locationIndicator[indexPath.row] == 6){
            cell.locationLabel.text = province + ", " + country
            
        //Has country
        }else if (locationIndicator[indexPath.row] == 7){
            cell.locationLabel.text = country
        }
        
        
        
        return cell
    }
   
    
    //MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    //MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var streetNumber = ""
        var streetName = ""
        var subCity = ""
        var city = ""
        var municipality = ""
        var province = ""
        var postal = ""
        var country = ""
        let region = ""
        var ocean = ""
        var coordinate: CLLocationCoordinate2D?
        
        
        
            
        let cell = tableView.cellForRow(at: indexPath) as! PlaceCell
        
        selectedName = cell.nameLabel.text!
        selectedSubtitle = cell.locationLabel.text!

            
        if (!selectedName.isEmpty){
            streetNumber = places[indexPath.row].placemark.subThoroughfare ?? ""
            streetName = places[indexPath.row].placemark.thoroughfare ?? ""
            subCity = places[indexPath.row].placemark.subLocality ?? ""
            city = places[indexPath.row].placemark.locality ?? ""
            municipality = places[indexPath.row].placemark.subAdministrativeArea ?? ""
            province = places[indexPath.row].placemark.administrativeArea ?? ""
            postal = places[indexPath.row].placemark.postalCode ?? ""
            country = places[indexPath.row].placemark.country ?? ""
            ocean = places[indexPath.row].placemark.ocean ?? ""
            coordinate = places[indexPath.row].placemark.coordinate
            
            let selectedPlacemark = PlacemarkAnnotation(title: "", info: "",streetNumber: streetNumber, streetName: streetNumber, subCity: subCity, city: city, municipality: municipality, province: province, postal: postal, country: country, region: region, ocean: ocean, coordinate: coordinate!)

            tableView.isHidden = true
            tableView.isUserInteractionEnabled = false
            
         
            if (map.annotations.count != 0){
                map.removeAnnotations(map.annotations)
            }

            map.addAnnotation(selectedPlacemark)

            map.setCenter(selectedPlacemark.coordinate, animated: true)
            
            cancelSearch()
            
            //Assigning the value of the location to the values in TrekStruct
            AllTreks.treksArray[AllTreks.treksArray.count-1].streetName = streetName
            AllTreks.treksArray[AllTreks.treksArray.count-1].streetNumber = streetNumber
            AllTreks.treksArray[AllTreks.treksArray.count-1].subCity = subCity
            AllTreks.treksArray[AllTreks.treksArray.count-1].city = city
            AllTreks.treksArray[AllTreks.treksArray.count-1].municipality = municipality
            AllTreks.treksArray[AllTreks.treksArray.count-1].province = province
            AllTreks.treksArray[AllTreks.treksArray.count-1].postal = postal
            AllTreks.treksArray[AllTreks.treksArray.count-1].region = region
            AllTreks.treksArray[AllTreks.treksArray.count-1].ocean = ocean
            AllTreks.treksArray[AllTreks.treksArray.count-1].country = country
            AllTreks.treksArray[AllTreks.treksArray.count-1].latitude = coordinate!.latitude
            AllTreks.treksArray[AllTreks.treksArray.count-1].longitude = coordinate!.longitude
            
            searchBar.endEditing(true)
            searchBar.text = ""
            places.removeAll()
            locationIndicator.removeAll()
            tableView.reloadData()
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        print("OKOK: \(selectedName)")
//        AllTreks.treksArray[AllTreks.treksArray.count-1].name = selectedName
//        dismiss(animated: true, completion: nil)
    }
    

    @objc func locationSelected(){
       
        print("-- TREK INFORMATION --\nName: \(selectedName)\nStreet Num: \(AllTreks.treksArray[AllTreks.treksArray.count-1].streetNumber)\nStreet Name: \(AllTreks.treksArray[AllTreks.treksArray.count-1].streetName)\nSubCity: \(AllTreks.treksArray[AllTreks.treksArray.count-1].subCity)\nCity: \(AllTreks.treksArray[AllTreks.treksArray.count-1].city)\nMunicipality: \(AllTreks.treksArray[AllTreks.treksArray.count-1].municipality)\nProvince: \(AllTreks.treksArray[AllTreks.treksArray.count-1].province)\nPostal: \(AllTreks.treksArray[AllTreks.treksArray.count-1].postal)\nRegion: \(AllTreks.treksArray[AllTreks.treksArray.count-1].region)\nCountry: \(AllTreks.treksArray[AllTreks.treksArray.count-1].country)\nOcean: \(AllTreks.treksArray[AllTreks.treksArray.count-1].ocean)\nLatitude: \(AllTreks.treksArray[AllTreks.treksArray.count-1].latitude)\nLongitude: \(AllTreks.treksArray[AllTreks.treksArray.count-1].longitude)\n--------")
        
        
        
        
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].city == ""){
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].province == ""){
                AllTreks.treksArray[AllTreks.treksArray.count-1].destination = AllTreks.treksArray[AllTreks.treksArray.count-1].country
            }else{
                AllTreks.treksArray[AllTreks.treksArray.count-1].destination = AllTreks.treksArray[AllTreks.treksArray.count-1].province + ", " + AllTreks.treksArray[AllTreks.treksArray.count-1].country
            }
        }else{
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].province == ""){
                
                if (selectedName == AllTreks.treksArray[AllTreks.treksArray.count-1].city){
                    AllTreks.treksArray[AllTreks.treksArray.count-1].destination = AllTreks.treksArray[AllTreks.treksArray.count-1].city + ", " + AllTreks.treksArray[AllTreks.treksArray.count-1].country
                }else{
                    AllTreks.treksArray[AllTreks.treksArray.count-1].destination =
                        selectedName + ", " + AllTreks.treksArray[AllTreks.treksArray.count-1].city + ", " + AllTreks.treksArray[AllTreks.treksArray.count-1].country
                }
                
                
            }else{
                
                if (selectedName == AllTreks.treksArray[AllTreks.treksArray.count-1].city){
                    AllTreks.treksArray[AllTreks.treksArray.count-1].destination = AllTreks.treksArray[AllTreks.treksArray.count-1].city + " " +
                    AllTreks.treksArray[AllTreks.treksArray.count-1].province + ", " + AllTreks.treksArray[AllTreks.treksArray.count-1].country
                }else{
                    AllTreks.treksArray[AllTreks.treksArray.count-1].destination =
                        selectedName + ", " +
                        AllTreks.treksArray[AllTreks.treksArray.count-1].city + " " +
                        AllTreks.treksArray[AllTreks.treksArray.count-1].province + ", " +
                        AllTreks.treksArray[AllTreks.treksArray.count-1].country
                }
                
            }
        }
        
//        print("WHAT: \(AllTreks.treksArray[AllTreks.treksArray.count-1].destination)")
        dismiss(animated: true, completion: nil)
    }
  
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is PlacemarkAnnotation else { return nil }
        
        

        let identifier = "PlacemarkAnnotation"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            
        } else {
            annotationView?.annotation = annotation
        }
        
        let backdropLabel = UITextView()
        backdropLabel.translatesAutoresizingMaskIntoConstraints = false
        backdropLabel.backgroundColor = SingletonStruct.testBlue
        backdropLabel.clipsToBounds = true
        backdropLabel.layer.cornerRadius = 10

        let backdropInfo = UITextView()
        backdropInfo.translatesAutoresizingMaskIntoConstraints = false
        backdropInfo.backgroundColor = UIColor(red: 79/255, green: 135/255, blue: 255/255, alpha: 1.0)
        backdropInfo.clipsToBounds = true
        backdropInfo.layer.cornerRadius = 10

        let backdropSep = UITextView()
        backdropSep.translatesAutoresizingMaskIntoConstraints = false
        backdropSep.backgroundColor = UIColor(red: 79/255, green: 135/255, blue: 255/255, alpha: 1.0)
        backdropSep.clipsToBounds = true


        let annotationTitle = UILabel()
        annotationTitle.translatesAutoresizingMaskIntoConstraints = false
        annotationTitle.backgroundColor = .clear
        annotationTitle.clipsToBounds = true
        annotationTitle.font = SingletonStruct.mapTitleFont
        annotationTitle.textColor = .black
        annotationTitle.textAlignment = .left
        annotationTitle.text = selectedName
        annotationTitle.numberOfLines = 1

        let annotationSubTitle = UILabel()
        annotationSubTitle.translatesAutoresizingMaskIntoConstraints = false

        annotationSubTitle.clipsToBounds = true
        annotationSubTitle.font = SingletonStruct.mapSubTitleFont
        annotationSubTitle.textColor = .black
        annotationSubTitle.textAlignment = .left
        annotationSubTitle.text = selectedSubtitle
        annotationSubTitle.numberOfLines = 1

    
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "location_select"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(MapViewController.locationSelected), for: .touchDown)

        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        let testView = UIView()
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        testView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        testView.clipsToBounds = true


        //title
        parentView.addSubview(annotationTitle)
        parentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        annotationTitle.bottomAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        annotationTitle.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        

        //subtitle
        parentView.addSubview(annotationSubTitle)
        annotationSubTitle.leadingAnchor.constraint(equalTo: annotationTitle.leadingAnchor).isActive = true
        annotationSubTitle.topAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        annotationSubTitle.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 150).isActive = true
        
        annotationTitle.widthAnchor.constraint(equalTo: annotationSubTitle.widthAnchor).isActive = true
       
        parentView.addSubview(button)
        button.leadingAnchor.constraint(equalTo: annotationSubTitle.trailingAnchor, constant: 5).isActive = true
        button.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

        parentView.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true


        annotationView!.detailCalloutAccessoryView = parentView

        return annotationView
    }
    
    
    //MARK: Setup Map
    private func setupMap(){
        map.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(map)
        
        map.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        map.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
 
    //MARK: noConnectionNavBar
    private func noConnectionNavBar(){
//        let patchView = UIView()
//        patchView.translatesAutoresizingMaskIntoConstraints = false
//        patchView.backgroundColor = SingletonStruct.testBlue
//
//        view.addSubview(patchView)
//        patchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        patchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        patchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    
        navBar.isTranslucent = false
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .red
        navBar.tintColor = SingletonStruct.testBlue
        
        view.addSubview(navBar)
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
//        patchView.bottomAnchor.constraint(equalTo: navBar.topAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "")
        
        let backItem = UIBarButtonItem(image: UIImage(named: "xa"), style: .plain, target: self, action: #selector(MapViewController.cancelMap))
            
        navItem.leftBarButtonItem = backItem
        
        navBar.setItems([navItem], animated: false)
    }
    
    
    //MARK: noConnectionUI
    private func setupNoConnectionUI(){
        view.backgroundColor = .white
        
    
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
        
        let backItem = UIBarButtonItem(image: UIImage(named: "xa"), style: .plain, target: self, action: #selector(MapViewController.cancelMap))
        
        
    
        
        navItem.leftBarButtonItem = backItem
        navItem.titleView = searchBar
        
        navBar.setItems([navItem], animated: false)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        print("afjsdkjfklsjflkfjg")
    }
    
    
    //MARK: searchBarTextDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        places.removeAll()
        locationIndicator.removeAll()
        tableView.reloadData()
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        searchString(location: searchBar.text ?? "")
    }
    
    
    //Searching for location
    private func searchString(location: String){

        searchRequest.naturalLanguageQuery = location
        let search = MKLocalSearch(request: searchRequest)
        
        var counter = 0
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
                    print("Places Size: \(self.places.count)\nLocation Indicator Size: \(self.locationIndicator.count)")
                }
                
                
            }
            
            self.tableView.reloadData()
            counter += 1
        }
    }
    
    //MARK: Check location
    func checkLocation(location: MKMapItem) -> Bool{
        var locationGood = false
        
        let address = location.placemark.subThoroughfare?.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .symbols) ?? ""
        let street = location.placemark.thoroughfare?.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .symbols) ?? ""
        let city = location.placemark.locality?.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .symbols) ?? ""
        let province = location.placemark.administrativeArea?.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .symbols) ?? ""
        let postal = location.placemark.postalCode?.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .symbols) ?? ""
        let country = location.placemark.countryCode?.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .symbols) ?? ""
        
        //Has everything
        if (!address.isEmpty && !street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
            locationGood = true
            
        //All but address
        }else if (!street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
            locationGood = true
        }
            
        
        //city, province, postal, country
        else if (!city.isEmpty && !province.isEmpty && !postal.isEmpty){
            locationGood = true
            
            
        
        }
        //city, province, country
        else if (!city.isEmpty && !province.isEmpty){
            locationGood = true

        }
            
        //city, country
        else if (!city.isEmpty){
            locationGood = true
            
        }
            
        //province, country
        else if (!province.isEmpty){
            locationGood = true
            
        }
            
            
        //country
        else if (!country.isEmpty){
            locationGood = true
            
            
        }
        
        if (locationGood){
            //Has everything
            if (!address.isEmpty && !street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
                locationIndicator.append(1)
                
            //All but address
            }else if (!street.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
                locationIndicator.append(2)
            }
                
            
            //city, province, postal, country
            else if (!city.isEmpty && !province.isEmpty && !postal.isEmpty){
                locationIndicator.append(3)
                
                
            
            }
            //city, province, country
            else if (!city.isEmpty && !province.isEmpty){
                locationIndicator.append(4)

            }
                
            //city, country
            else if (!city.isEmpty){
                locationIndicator.append(5)
                
            }
                
            //province, country
            else if (!province.isEmpty){
                locationIndicator.append(6)
                
            }
                
                
            //country
            else if (!country.isEmpty){
                locationIndicator.append(7)
                
                
            }
        }
        
        return locationGood
        
    }
    


    //MARK: searchBarBegingEditing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if (tableView.isHidden){
            tableView.isHidden = false
            tableView.isUserInteractionEnabled = true
        }
        
        let navItem = UINavigationItem(title: "")
            
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MapViewController.cancelSearch))
        
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: SingletonStruct.subHeaderFontv2], for: .normal)
        
        navItem.rightBarButtonItem = cancelButton
        navItem.titleView = searchBar
            
        navBar.setItems([navItem], animated: false)
    }
    
    //MARK: cancelSearch
    @objc func cancelSearch(){
        let navItem = UINavigationItem(title: "")
            
        let backItem = UIBarButtonItem(image: UIImage(named: "xa"), style: .plain, target: self, action: #selector(MapViewController.cancelMap))
        
        navItem.leftBarButtonItem = backItem
        navItem.titleView = searchBar
        
        navBar.setItems([navItem], animated: false)
        
        places.removeAll()
        locationIndicator.removeAll()
        tableView.reloadData()
        searchBar.endEditing(true)
        searchBar.text = ""
        tableView.isHidden = true
        tableView.isUserInteractionEnabled = false
    }
    
   
   
    //MARK: searchBarButtonClicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        places.removeAll()
        locationIndicator.removeAll()
        tableView.reloadData()
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }
    
    
    //MARK: cancelMap
    @objc func cancelMap(){
        if (hasConnection){
            if (tableView.isHidden){
                dismiss(animated: true, completion: nil)
            }else{
                tableView.isHidden = true
                tableView.isUserInteractionEnabled = false
                searchBar.endEditing(true)
                places.removeAll()
                locationIndicator.removeAll()
                tableView.reloadData()
            }
        }else{
            dismiss(animated: true, completion: nil)
        }
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
        nameLabel.font = SingletonStruct.subHeaderFont
        nameLabel.numberOfLines = 1
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = SingletonStruct.subHeaderFont.withSize(13)
        locationLabel.numberOfLines = 1
        locationLabel.minimumScaleFactor = 0.5
        locationLabel.textColor = .darkGray
    }
    
    
    private func setupConstraints(){
        
        addSubview(destinationIcon)
        destinationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        destinationIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        destinationIcon.heightAnchor.constraint(equalToConstant : frame.height/2.5 ).isActive = true
        destinationIcon.widthAnchor.constraint(equalToConstant: frame.height/2.5).isActive = true
        
        
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



extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
      let size = self.size
      let widthRatio  = targetSize.width  / size.width
      let heightRatio = targetSize.height / size.height
      let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
      let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

      UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
      self.draw(in: rect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage!
    }
}
