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
    
    func createAddressFromCLPlaceMark(_ geoLoc: CLPlacemark) -> String {
        var adressString : String = ""
        
        if geoLoc.thoroughfare != nil {
            adressString = adressString + geoLoc.thoroughfare! + ", "
        }
        if geoLoc.subThoroughfare != nil {
            adressString = adressString + geoLoc.subThoroughfare! + "\n"
        }
        if geoLoc.locality != nil {
            adressString = adressString + geoLoc.locality! + " - "
        }
        if geoLoc.postalCode != nil {
            adressString = adressString + geoLoc.postalCode! + "\n"
        }
        if geoLoc.subAdministrativeArea != nil {
            adressString = adressString + geoLoc.subAdministrativeArea! + " - "
        }
        if geoLoc.country != nil {
            adressString = adressString + geoLoc.country!
        }
        return adressString
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("coords - \(lat),\(long)")
            
            lookUpCurrentLocation { geoLoc in
                print("GEO LOCATION = \(geoLoc?.locality ?? "locatie necunoscuta")")
                guard let geoLoc = geoLoc else {
                    print("No address")
                    return
                }
                print("adresa = \(self.createAddressFromCLPlaceMark(geoLoc))")
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
