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

///Todo: Add functionality which shows cool things to do at the selected location

//MARK: Class declaration
class MapViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    var places = [MKMapItem]()
    var locationIndicator = [Int]()
    
    var selectedName = ""
    var selectedSubtitle = ""
    
    
    let map = MKMapView()
//    var selectedPlacemark = MKPlacemark()
    
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
        var streetAddress = ""
        var streetName = ""
        var city = ""
        var province = ""
        var postal = ""
        var country = ""
        
        
        cell.nameLabel.text = places[indexPath.row].name
        
        streetNumber = places[indexPath.row].placemark.subThoroughfare ?? ""
//        streetAddress = places[indexPath.row].placemark.subLocality ?? ""
        streetName = places[indexPath.row].placemark.thoroughfare ?? ""
        city = places[indexPath.row].placemark.locality ?? ""
        province = places[indexPath.row].placemark.administrativeArea ?? ""
        postal = places[indexPath.row].placemark.postalCode ?? ""
        
//        let test = places[indexPath.row].placemark.subThoroughfare ?? "failed."
//        let test2 = places[indexPath.row].placemark.locality ?? "oops."
//        print("locality: \(test2) subThoroughfare: \(test)")
        
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
       
//        print("POSTAL ADDRESS TEST: \(places[indexPath.row].placemark.postalAddress)")
//
//        print("FULL BODY TEXT ----\n\(places[indexPath.row])\n-----")
//
//        print("LOCATION INFORMATION ----\nLOCATION INDICATOR VALUE: \(locationIndicator[indexPath.row])\nNAME: \(places[indexPath.row].name)\nNUMBER: \(streetNumber)\nSTREET: \(streetName)\nCITY: \(city)\nPROVINCE: \(province)\nPOSTAL: \(postal)\nCOUNTRY: \(country)\n-----")
        
        
        
        return cell
    }
   
    //MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    //MARK: didSelectRowAt
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            selectedName = places[indexPath.row].name ?? ""
            
            if (!selectedName.isEmpty){
                print("Places Count: \(places.count)")
                print("Indexpath Row: \(indexPath.row)")
                
                tableView.isHidden = true
                tableView.isUserInteractionEnabled = false
                
//                selectedName = places[indexPath.row].placemark.name
                
                let annotation = MKPointAnnotation()
                
               
                
                

                annotation.coordinate = places[indexPath.row].placemark.coordinate

                annotation.title = "Title"
                annotation.subtitle = "Subtitle"


                map.addAnnotation(annotation)

                map.setCenter(annotation.coordinate, animated: true)
    
                places.removeAll()
                locationIndicator.removeAll()
            }
        }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"

        if annotation is MKUserLocation {
            return nil
        }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "mkmap-pin")
            
            
            let label = UILabel()
            label.text = "THIS IS A TEST"
            label.textColor = .black
            
            annotationView?.addSubview(label)

            // if you want a disclosure button, you'd might do something like:
            //
            // let detailButton = UIButton(type: .detailDisclosure)
            // annotationView?.rightCalloutAccessoryView = detailButton
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    


    
    
    //MARK: Setup Map
    private func setupMap(){
//        let map = MKMapView()
        
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
