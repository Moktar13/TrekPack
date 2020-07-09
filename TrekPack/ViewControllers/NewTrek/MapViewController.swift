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
    
    var places = [MKMapItem]()
    var locationIndicator = [Int]()
    
    var selectedName = ""
    var selectedSubtitle = ""
    
    
    let map = MKMapView()

    
    var locationValueIndicator = 0
    
    let navBar = UINavigationBar()
    let searchBar = UISearchBar()
    let searchRequest = MKLocalSearch.Request()
    
    let cellID = "cellID"
    
    let tableView = UITableView()
    
    
    deinit {
        print("Deinitializing MapViewController")
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchPin))
        gestureRecognizer.delegate = self
        map.addGestureRecognizer(gestureRecognizer)
        
        map.delegate = self
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: cellID)
        
        setupMap()
        setupNavigationBar()
        setupTableView()
    
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
        var region = ""
        var ocean = ""



       
        
        let location = gestureRecognizer.location(in: map)
        let coordinate = map.convert(location, toCoordinateFrom: map)
        
        if (map.annotations.count != 0){
        map.removeAnnotations(map.annotations)
        }
        

        
        let address = CLGeocoder.init()
        
        address.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude:coordinate.longitude)) { (places, error) in
            
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
                    
                    //Getting location subtitle
                    
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
                    
                    
                    // Add annotation:
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    
                    
                    self.map.addAnnotation(annotation)
                    
                    
                    self.map.setCenter(annotation.coordinate, animated: true)
                    
                    
                    print("locality: \(city)\nsubLocality: \(place[0].subLocality)\nadministrativeArea: \(province)\nsubAdministrativeArea: \(place[0].subAdministrativeArea)")
                    
                    
                    
//                    self.selectedName = place[0].locality ?? place[0].administrativeArea ?? "oops"
                
                }else{
                    print("Something went wrong...")
            }
            
            
            
        }
        
        
        
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
        var city = ""
        var province = ""
        var postal = ""
        var country = ""
        
        
        cell.nameLabel.text = places[indexPath.row].name
        
        streetNumber = places[indexPath.row].placemark.subThoroughfare ?? ""
        streetName = places[indexPath.row].placemark.thoroughfare ?? ""
        city = places[indexPath.row].placemark.locality ?? ""
        province = places[indexPath.row].placemark.administrativeArea ?? ""
        postal = places[indexPath.row].placemark.postalCode ?? ""
        

        
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
            
        let cell = tableView.cellForRow(at: indexPath) as! PlaceCell
        
        selectedName = cell.nameLabel.text!
        selectedSubtitle = cell.locationLabel.text!

            
        if (!selectedName.isEmpty){
            print("Places Count: \(places.count)")
            print("Indexpath Row: \(indexPath.row)")

            tableView.isHidden = true
            tableView.isUserInteractionEnabled = false
            
            let annotation = MKPointAnnotation()

            annotation.coordinate = places[indexPath.row].placemark.coordinate

            if (map.annotations.count != 0){
            map.removeAnnotations(map.annotations)
            }

            map.addAnnotation(annotation)

            map.setCenter(annotation.coordinate, animated: true)

            places.removeAll()
            locationIndicator.removeAll()
            tableView.reloadData()
        }
    }
    
    
    
    //MARK: Adding Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        
        print("NAME: \(selectedName)\nSubName:\(selectedSubtitle)")

        let identifier = "Annotation"
        
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
        annotationTitle.textColor = .white
        annotationTitle.textAlignment = .left
        annotationTitle.text = selectedName
        annotationTitle.numberOfLines = 1
        
        let annotationSubTitle = UILabel()
        annotationSubTitle.translatesAutoresizingMaskIntoConstraints = false
        annotationSubTitle.backgroundColor = UIColor(red: 79/255, green: 135/255, blue: 255/255, alpha: 1.0)
        annotationSubTitle.clipsToBounds = true
        annotationSubTitle.font = SingletonStruct.mapSubTitleFont
        annotationSubTitle.textColor = .white
        annotationSubTitle.textAlignment = .left
        annotationSubTitle.text = selectedSubtitle
        annotationSubTitle.numberOfLines = 1
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.backgroundColor = SingletonStruct.testBlue
        imgView.image = UIImage(named: "test-send")

        
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "right"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 10
        
        
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        
        
        if annotationView == nil {
            
            print("Is Nil")
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true

        } else {
            print("Not Nil")
            
            annotationView!.annotation = annotation
        
            for view in annotationView!.subviews {
                view.removeFromSuperview()
            }
        }
    
        //backdropinfo
        annotationView!.addSubview(backdropInfo)
        backdropInfo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backdropInfo.centerXAnchor.constraint(equalTo: annotationView!.leadingAnchor, constant: 35).isActive = true
        backdropInfo.bottomAnchor.constraint(equalTo: annotationView!.topAnchor, constant: -5).isActive = true
    
        
        //title
       annotationView!.addSubview(annotationTitle)
       annotationTitle.topAnchor.constraint(equalTo: backdropInfo.topAnchor, constant: 5).isActive = true
       annotationTitle.bottomAnchor.constraint(equalTo: backdropInfo.centerYAnchor).isActive = true
                       
        print("Screen width: \(view.frame.width)")
        
        //subtitle
        annotationView!.addSubview(annotationSubTitle)
        annotationSubTitle.leadingAnchor.constraint(equalTo: annotationTitle.leadingAnchor).isActive = true
        annotationSubTitle.topAnchor.constraint(equalTo: backdropInfo.centerYAnchor).isActive = true
        annotationSubTitle.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        annotationSubTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        annotationTitle.widthAnchor.constraint(equalTo: annotationSubTitle.widthAnchor).isActive = true
       
        backdropInfo.leadingAnchor.constraint(equalTo: annotationTitle.leadingAnchor, constant: -10).isActive = true
        backdropInfo.trailingAnchor.constraint(equalTo: annotationTitle.trailingAnchor, constant: 50).isActive = true
       
        //backdrop sep
        annotationView!.addSubview(backdropSep)
        backdropSep.widthAnchor.constraint(equalToConstant: 10).isActive = true
        backdropSep.topAnchor.constraint(equalTo: backdropInfo.topAnchor).isActive = true
        backdropSep.bottomAnchor.constraint(equalTo: backdropInfo.bottomAnchor).isActive = true
        backdropSep.trailingAnchor.constraint(equalTo: backdropInfo.leadingAnchor, constant: 10).isActive = true
        
        //icon backdrop
        annotationView!.addSubview(backdropLabel)
        backdropLabel.bottomAnchor.constraint(equalTo: backdropSep.bottomAnchor).isActive = true
        backdropLabel.topAnchor.constraint(equalTo: backdropSep.topAnchor).isActive = true
        backdropLabel.trailingAnchor.constraint(equalTo: backdropSep.trailingAnchor).isActive = true
        backdropLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        //img view
        annotationView!.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: backdropLabel.centerXAnchor, constant: -5).isActive = true
        imgView.centerYAnchor.constraint(equalTo: backdropLabel.centerYAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        annotationView!.sendSubviewToBack(backdropLabel)
        
        //button
        annotationView!.addSubview(button)
        button.trailingAnchor.constraint(equalTo: backdropInfo.trailingAnchor, constant: -5).isActive = true
        button.leadingAnchor.constraint(equalTo: annotationTitle.trailingAnchor, constant: 5).isActive = true
        button.centerYAnchor.constraint(equalTo: backdropInfo.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    

        return annotationView
    }
    
  
    
    

    
    
    //MARK: Setup Map
    private func setupMap(){
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
        locationIndicator.removeAll()
        tableView.reloadData()
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        searchString(location: searchBar.text ?? "")
    }
    
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
    


    //MARK: Search
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if (tableView.isHidden){
            tableView.isHidden = false
            tableView.isUserInteractionEnabled = true
        }
    }
    
   
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        places.removeAll()
        locationIndicator.removeAll()
        tableView.reloadData()
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
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
