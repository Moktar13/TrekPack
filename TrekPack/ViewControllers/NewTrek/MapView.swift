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
import Network

// ~ Class which provides users with the ability to search (via search bar or map select) a viable location for their Trek ~
class MapViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    //MapView
    var places = [MKMapItem]()
    var locationIndicator = [Int]()
    var selectedName = ""
    var selectedSubtitle = ""
    let map = MKMapView()
    let annotationID = "annotationID"
    var locationValueIndicator = 0
    
    //Connection
    var hasConnection = false

    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    
    //Nav & Search Bar
    let navBar = UINavigationBar()
    let searchBar = UISearchBar()
    let searchRequest = MKLocalSearch.Request()
    
    //Tableview
    let cellID = "cellID"
    let tableView = UITableView()
    
    //MARK: deinit
    deinit {
        print("Deinitializing MapViewController")
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
//        monitor.start(queue: queue)
//        monitor.cancel()
//        monitor.pathUpdateHandler = { path in
//
//            if path.status == .satisfied {
//                self.hasConnection = true
//            } else {
//                self.hasConnection = false
//            }
//        }
//
//        monitor.cancel()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//
//        }
        
        setupUI()
    }
    
    private func setupUI(){
        
        hasConnection = true
        
        if (hasConnection == true){
            //Create gestureRecognizer for the map
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchPin))
            gestureRecognizer.delegate = self
            map.addGestureRecognizer(gestureRecognizer)
            map.delegate = self
            
            //SearchBar settings
            searchBar.searchTextField.font = SingletonStruct.subHeaderFont
            searchBar.placeholder = "Search"
            searchBar.delegate = self
            
            //TableView settings
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(PlaceCell.self, forCellReuseIdentifier: cellID)
            
            //Method calls
            setupMap()
            setupNavigationBar()
            setupTableView()
        }else{
            print("Internet Connection not Available!")
            setupNoConnectionUI()
            noConnectionNavBar()
        }
    }
    
    //MARK: touchPin
    @objc func touchPin(gestureRecognizer: UILongPressGestureRecognizer){
    
        spinner.startAnimating()
        map.isUserInteractionEnabled = false
        
        //Function variables
        var streetNumber = ""
        var streetName = ""
        var subCity = ""
        var city = ""
        var municipality = ""
        var province = ""
        var postal = ""
        var country = ""
        var countryISO = ""
        let region = ""
        var ocean = ""
        var coordinate: CLLocationCoordinate2D?
        var timeZone = ""

        
        let location = gestureRecognizer.location(in: map)
        coordinate = map.convert(location, toCoordinateFrom: map)
        
        //Removing all annotations
        if (map.annotations.count != 0){
            map.removeAnnotations(map.annotations)
        }
    
        let address = CLGeocoder.init()
        
        //Reverse GeoCoding the location based on the latitude and longitude so that it can be decoded to retrieve the locations specific values
        address.reverseGeocodeLocation(CLLocation.init(latitude: coordinate!.latitude, longitude:coordinate!.longitude)) { (places, error) in
            
                if let place = places{
                    
                    //Getting the characteristics of the place
                    streetNumber = place[0].subThoroughfare ?? ""
                    streetName = place[0].thoroughfare ?? ""
                    subCity = place[0].subLocality ?? ""
                    city = place[0].locality ?? ""
                    municipality = place[0].subAdministrativeArea ?? ""
                    province = place[0].administrativeArea ?? ""
                    postal = place[0].postalCode ?? ""
                    country = place[0].country ?? ""
                    countryISO = place[0].isoCountryCode ?? ""
                    ocean = place[0].ocean ?? ""
                    timeZone = place[0].timeZone?.abbreviation() ?? ""
                    
                
                    
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
                    }
                        
                    //All but address
                    else if (!streetName.isEmpty && !city.isEmpty && !province.isEmpty && !postal.isEmpty){
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
                    

                    //Creating PlacemarkAnnotation object with vlaues found in the place
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
                    AllTreks.treksArray[AllTreks.treksArray.count-1].countryISO = countryISO
                    AllTreks.treksArray[AllTreks.treksArray.count-1].latitude = coordinate!.latitude
                    AllTreks.treksArray[AllTreks.treksArray.count-1].longitude = coordinate!.longitude
                    AllTreks.treksArray[AllTreks.treksArray.count-1].timeZone = timeZone
                    
                    
                    print("country tableview: \(country )")
                    self.button.setImage(UIImage(named: "location_select"), for: .normal)
                    self.button.isEnabled = true
                    //Only allow user to select country locations
//                    if (country == ""){
//                        self.button.setImage(UIImage(), for: .normal)
//                        self.button.setImage(UIImage(named: "location_no_select"), for: .normal)
////                        self.button.isEnabled = false
//
//                    }else{
//                        self.button.setImage(UIImage(named: "location_select"), for: .normal)
//                        self.button.isEnabled = true
//                    }
                    
                    //Only show the pin if the selected name is not empty
                    if (self.selectedName != ""){
                        self.map.addAnnotation(selectedPlacemark)
                        self.map.setCenter(selectedPlacemark.coordinate, animated: true)
                    }
                    self.spinner.stopAnimating()
                    self.map.isUserInteractionEnabled = true
                }else{
                    self.spinner.stopAnimating()
                    self.map.isUserInteractionEnabled = true
            }
        }
    }
    
    
    //MARK: didAdd
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        map.selectAnnotation(map.annotations[0], animated: true)
    }
    
    
    //MARK: preferStatusBarHidden
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //MARK: Setup TableView
    func setupTableView(){
        
        //tableView settings
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.isUserInteractionEnabled = false
        
        //NSLayoutConstraint for tableView
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0.25).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(searchSpinner)
        searchSpinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        searchSpinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -view.frame.height/6).isActive = true
        
    }
    
    
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        //Function variable declaration
        var streetNumber = ""
        var streetName = ""
        var city = ""
        var province = ""
        var postal = ""
        var country = ""

        //Setting the cells nameLabel to the name of the location found in places at indexPath.row
        cell.nameLabel.text = places[indexPath.row].name
        
        //Retrieving the values of the placemark
        streetNumber = places[indexPath.row].placemark.subThoroughfare ?? ""
        streetName = places[indexPath.row].placemark.thoroughfare ?? ""
        city = places[indexPath.row].placemark.locality ?? ""
        province = places[indexPath.row].placemark.administrativeArea ?? ""
        postal = places[indexPath.row].placemark.postalCode ?? ""
        country = places[indexPath.row].placemark.country ?? ""
        

        
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
        
        //Function variable declaration
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
        let timeZone = ""
        var countryISO = ""
        
        //Getting selected cell
        let cell = tableView.cellForRow(at: indexPath) as! PlaceCell
        
        //Getting the name and subtitle of the cell
        selectedName = cell.nameLabel.text!
        selectedSubtitle = cell.locationLabel.text!

        //If the selected cell is not empty
        if (!selectedName.isEmpty){
            
            //Retrieving information of the placemark
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
            countryISO = places[indexPath.row].placemark.isoCountryCode ?? ""
        
            
            //Creating a PlaceMarkAnnotation object with the retrieved values above
            let selectedPlacemark = PlacemarkAnnotation(title: "", info: "",streetNumber: streetNumber, streetName: streetNumber, subCity: subCity, city: city, municipality: municipality, province: province, postal: postal, country: country, region: region, ocean: ocean, coordinate: coordinate!)

            
            //Hiding and disabling the tableView
            tableView.isHidden = true
            tableView.isUserInteractionEnabled = false
            
            //Removing all existing annoations from the map view
            if (map.annotations.count != 0){
                map.removeAnnotations(map.annotations)
            }


            //Adding a annotation and centering the map to the newly added annotation
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
            AllTreks.treksArray[AllTreks.treksArray.count-1].timeZone = timeZone
            AllTreks.treksArray[AllTreks.treksArray.count-1].countryISO = countryISO
            
            //Clearing searchBar, places, locationIndicator and reloading the tableView
            searchBar.endEditing(true)
            searchBar.text = ""
            places.removeAll()
            locationIndicator.removeAll()
            tableView.reloadData()
        }
    }
    
    
    
    //MARK: locationSelected
    @objc func locationSelected(){
       
//        print("-- TREK INFORMATION --\nName: \(selectedName)\nStreet Num: \(AllTreks.treksArray[AllTreks.treksArray.count-1].streetNumber)\nStreet Name: \(AllTreks.treksArray[AllTreks.treksArray.count-1].streetName)\nSubCity: \(AllTreks.treksArray[AllTreks.treksArray.count-1].subCity)\nCity: \(AllTreks.treksArray[AllTreks.treksArray.count-1].city)\nMunicipality: \(AllTreks.treksArray[AllTreks.treksArray.count-1].municipality)\nProvince: \(AllTreks.treksArray[AllTreks.treksArray.count-1].province)\nPostal: \(AllTreks.treksArray[AllTreks.treksArray.count-1].postal)\nRegion: \(AllTreks.treksArray[AllTreks.treksArray.count-1].region)\nCountry: \(AllTreks.treksArray[AllTreks.treksArray.count-1].country)\nOcean: \(AllTreks.treksArray[AllTreks.treksArray.count-1].ocean)\nLatitude: \(AllTreks.treksArray[AllTreks.treksArray.count-1].latitude)\nLongitude: \(AllTreks.treksArray[AllTreks.treksArray.count-1].longitude)\n--------")
        
        //Creating new CLLocation object based on the latitude and longitude values of the selected location
        let location = CLLocation(latitude: AllTreks.treksArray[AllTreks.treksArray.count-1].latitude, longitude: AllTreks.treksArray[AllTreks.treksArray.count-1].longitude)
        
        //Creating new CLGeoCoder object and reverseGeoCoding it to get the timeZone
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
             if let placemark = placemarks?[0] {
                AllTreks.treksArray[AllTreks.treksArray.count-1].timeZone = placemark.timeZone?.identifier ?? ""
             }
        }
        
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].country == ""){
            let alert = UIAlertController(title: "Oops!", message: "Your destination cannot be any large body of water.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
        
        //if the city is empty
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].city == ""){
            
            //if the province is empty set the dest to the country
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].province == ""){
                AllTreks.treksArray[AllTreks.treksArray.count-1].destination = AllTreks.treksArray[AllTreks.treksArray.count-1].country
  
            }
            //else set it to province and country
            else{
                AllTreks.treksArray[AllTreks.treksArray.count-1].destination = AllTreks.treksArray[AllTreks.treksArray.count-1].province + ", " + AllTreks.treksArray[AllTreks.treksArray.count-1].country
            }
        }else{
            //if province is empty
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].province == ""){
                
                //set dest to city and country, else set selected name, city and country
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
            
            //If the destination is empty, then set the destination to the ocean
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].destination.isEmpty){
                AllTreks.treksArray[AllTreks.treksArray.count-1].destination =
                AllTreks.treksArray[AllTreks.treksArray.count-1].ocean
            }
        }
        
        
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].destination.isEmpty){
                print("Destination is empty")
            }
            dismiss(animated: true, completion: nil)
        }
    }
  
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is PlacemarkAnnotation else { return nil }
        
        //Function variables
        let identifier = "PlacemarkAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        //If the annotationView is nil, then create a new MKPinAnnotationView with the annotation and reuseIdentifier
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
    
        //annotationTitle declaration
        let annotationTitle = UILabel()
        annotationTitle.translatesAutoresizingMaskIntoConstraints = false
        annotationTitle.backgroundColor = .clear
        annotationTitle.clipsToBounds = true
        annotationTitle.font = SingletonStruct.mapTitleFont
        annotationTitle.textColor = .black
        annotationTitle.textAlignment = .left
        annotationTitle.text = selectedName
        annotationTitle.numberOfLines = 1

        //annotationSubTitle declaration
        let annotationSubTitle = UILabel()
        annotationSubTitle.translatesAutoresizingMaskIntoConstraints = false
        annotationSubTitle.clipsToBounds = true
        annotationSubTitle.font = SingletonStruct.mapSubTitleFont
        annotationSubTitle.textColor = .black
        annotationSubTitle.textAlignment = .left
        annotationSubTitle.text = selectedSubtitle
        annotationSubTitle.numberOfLines = 1

        //parentView declaration
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        //parentView adding the annotation title
        parentView.addSubview(annotationTitle)
        parentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //annotationTitle anchors
        annotationTitle.bottomAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        annotationTitle.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true

        //parentView adding the annotation subTitle
        parentView.addSubview(annotationSubTitle)
        annotationSubTitle.leadingAnchor.constraint(equalTo: annotationTitle.leadingAnchor).isActive = true
        annotationSubTitle.topAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        annotationSubTitle.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 150).isActive = true
        
        //annotationTitle widthAnchor
        annotationTitle.widthAnchor.constraint(equalTo: annotationSubTitle.widthAnchor).isActive = true
       
        //parentView adding the button and setting its NSLayoutConstraints
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
    
        //NSLayoutConstraint for map
        view.addSubview(map)
        map.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        map.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        //NSLayoutConstraint for spinner
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.bringSubviewToFront(spinner)
    }
    
    
 
    //MARK: noConnectionNavBar
    private func noConnectionNavBar(){

        //navBar settings
        navBar.isTranslucent = false
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .red
        navBar.tintColor = SingletonStruct.testBlue
    
        //NSLayoutConstraint for navBar
        view.addSubview(navBar)
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        

        //Setting navBar items
        let navItem = UINavigationItem(title: "")
        let backItem = UIBarButtonItem(image: UIImage(named: "xa"), style: .plain, target: self, action: #selector(MapViewController.cancelMap))
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }
    
    
    //MARK: noConnectionUI
    private func setupNoConnectionUI(){
        view.backgroundColor = .white
        
        //imgView declaration and settings
        let imgView = UIImageView(image: UIImage(named: "wifi-off"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        
        //NSLayoutConstraint for imgView
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        
        //titleLabel declaration and settings
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = NSAttributedString(string: "Oops!", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        //NSLayoutConstraint for titleLabel
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //subTitleLabel declaration and settings
        let subTitleLabel = UILabel()
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.attributedText = NSAttributedString(string: "It looks like you lost internet connection\nPlease reconnect and try again", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv2, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        //NSLayoutConstraint for subTitleLabel
        view.addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
    }
    
    
    //MARK: Setup Navigation Bar
    private func setupNavigationBar(){
        
        //Required patch view that will cover the status bar area (needed because this view was not presented in the navigation controller stack)
        let patchView = UIView()
        patchView.translatesAutoresizingMaskIntoConstraints = false
        patchView.backgroundColor = .white
        
        //NSLayoutConstraint for patchView
        view.addSubview(patchView)
        patchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        patchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        patchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    
        //navBar settings
        navBar.isTranslucent = false
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .white
        
        //NSLayoutAnchor constraints for the navBar
        view.addSubview(navBar)
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        patchView.bottomAnchor.constraint(equalTo: navBar.topAnchor).isActive = true
        
        //Setting navBar items
        let navItem = UINavigationItem(title: "")
        let backItem = UIBarButtonItem(image: UIImage(named: "xa"), style: .plain, target: self, action: #selector(MapViewController.cancelMap))
        navItem.leftBarButtonItem = backItem
        navItem.titleView = searchBar
        navBar.setItems([navItem], animated: false)
    }
    
    
    //MARK: searchBarTextDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Clear all the saved places in the places and locationIndicator array and then reload the tableview
        places.removeAll()
        locationIndicator.removeAll()
        tableView.reloadData()
        
//        searchSpinner.startAnimating()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
//            self.searchSpinner.stopAnimating()
//        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
    
    
    //MARK: reload
    @objc func reload(_ searchBar: UISearchBar) {
        searchString(location: searchBar.text ?? "")
    }
    
    
    //Searching for location
    private func searchString(location: String){

        searchRequest.naturalLanguageQuery = location
        let search = MKLocalSearch(request: searchRequest)
        
        var counter = 0
        
        //Starting the search
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            //Iterating over the item in the search response map items array
            for location in response.mapItems {
                
                //If the location returned is not already in the places array then appen it
                if (self.checkLocation(location: location) && !self.places.contains(location)){
                    self.places.append(location)
                    
                }else{
                    print("Location already saved OR location has some error")
                }
            }
            
            self.tableView.reloadData()
            counter += 1
        }
    }
    
    //MARK: Check location
    func checkLocation(location: MKMapItem) -> Bool{
        var locationGood = false
        
        //Getting values from placemark
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
        
        //If the location is a good one, then append values into locationIndicator array indicating which values are retrievable
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
        
        //If the table view is hidden, show it and make user interaction allowed
        if (tableView.isHidden){
            tableView.isHidden = false
            tableView.isUserInteractionEnabled = true
        }
        
        //Setting UI for the navigation bar
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
        
        //If the user has a connection and if the tableView is hidden, then dismiss the tableview, other wise show hide the tableview and show the map
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
    
    
    //MARK: UI Declarations
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "location_select"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(MapViewController.locationSelected), for: .touchDown)
        return button
    }()

    let spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = SingletonStruct.testBlue
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    let searchSpinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = SingletonStruct.testBlue
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
           
}


//MARK: PlaceCell
class PlaceCell:UITableViewCell {
    
    //UI declarations for PlaceCell
    let nameLabel = UILabel()
    let locationLabel = UILabel()
    let destinationIcon:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "map-search-pin")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    
    //MARK: setupUI
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
    
    
    //MARK: setupConstraints
    private func setupConstraints(){
        
        //NSLayoutAnchor for destinationIcon
        addSubview(destinationIcon)
        destinationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        destinationIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        destinationIcon.heightAnchor.constraint(equalToConstant : frame.height/2.5 ).isActive = true
        destinationIcon.widthAnchor.constraint(equalToConstant: frame.height/2.5).isActive = true
        
        //NSLayoutAnchor for nameLabel
        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: destinationIcon.trailingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: destinationIcon.centerYAnchor).isActive = true
        
        //NSLayoutAnchor for locationLabel
        addSubview(locationLabel)
        locationLabel.leadingAnchor.constraint(equalTo: destinationIcon.trailingAnchor, constant: 5).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: destinationIcon.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
