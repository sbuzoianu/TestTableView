//
//  ViewController.swift
//  TestTableView
//
//  Created by Synergy on 20/06/2018.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet var loadingView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var offerTableView: UITableView!
    
    var countCell:Int? = nil
    var indexTable:Int = 10
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("countCell = \(String(describing: countCell))")
        activityIndicator.color = UIColor(red: 11/255, green: 86/255, blue: 14/255, alpha: 1)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        prepareTableView()

    }
    
    func prepareTableView() {
        offerTableView.dataSource = self
        print("ViewController - \(OfferTableViewCell.ReuseIdentifier)")
        
        let nib = UINib(nibName: OfferTableViewCell.NibName, bundle: .main)
        offerTableView.register(nib, forCellReuseIdentifier: OfferTableViewCell.ReuseIdentifier)
    }
    
    
    func getAdressName(coords: CLLocation) {

        CLGeocoder().reverseGeocodeLocation(coords) { (placemark, error) in
            if error != nil {
                
                print("Hay un error")
                
            } else {
                
                let place = placemark! as [CLPlacemark]
                
                if place.count > 0 {
                    let place = placemark![0]
                    
                    var adressString : String = ""
                    
                    if place.thoroughfare != nil {
                        adressString = adressString + place.thoroughfare! + ", "
                    }
                    if place.subThoroughfare != nil {
                        adressString = adressString + place.subThoroughfare! + "\n"
                    }
                    if place.locality != nil {
                        adressString = adressString + place.locality! + " - "
                    }
                    if place.postalCode != nil {
                        adressString = adressString + place.postalCode! + "\n"
                    }
                    if place.subAdministrativeArea != nil {
                        adressString = adressString + place.subAdministrativeArea! + " - "
                    }
                    if place.country != nil {
                        adressString = adressString + place.country!
                    }
                    
                    print("adresa = \(adressString)")
                }
                
            }
        }
    }

    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("\(lat),\(long)")
            let loc: CLLocation = CLLocation(latitude:lat, longitude: long)
            getAdressName(coords: loc)
            lookUpCurrentLocation { geoLoc in
                print("GEO LOCATION = \(geoLoc?.locality ?? "locatie necunoscuta")")
            }
            
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
}
