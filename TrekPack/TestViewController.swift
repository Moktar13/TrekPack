//
//  TestViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

//
//  TestViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import MapKit

class TestViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    let mapView = MKMapView()
  
    var test:MKAnnotation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TestViewController.touchPin))
        gestureRecognizer.delegate = self
        
        mapView.addGestureRecognizer(gestureRecognizer)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
             */
         
        
    }
    
   /*func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           guard annotation is Capital else { return nil }

           let identifier = "Capital"

           var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

           if annotationView == nil {
               annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               annotationView?.canShowCallout = true

            let btn = UIButton(type: .infoLight)
               annotationView?.rightCalloutAccessoryView = btn
           } else {
               annotationView?.annotation = annotation
           }

           return annotationView
       }
    

    
    @objc func touchPin(gestureRecognizer: UILongPressGestureRecognizer){
               
        print("touchPin")
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            
            
        if (mapView.annotations.count > 0){
            mapView.removeAnnotations(mapView.annotations)
        }
        
            let address = CLGeocoder.init()
            
            address.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude:coordinate.longitude)) { (places, error) in
                
                print("ass")
                        // Add annotation:
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                                
                                    
                    var test = Capital(title: "Test", coordinate: coordinate, info: "Info")
                        
                    self.mapView.addAnnotation(test)
                            
                self.test = annotation
                                
                    self.mapView.setCenter(annotation.coordinate, animated: true)
                
                 
                    
                }
            
                
            
        }
       
     func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        self.mapView.selectAnnotation(self.mapView.annotations[0], animated: true)
    }*/
}
        
   
