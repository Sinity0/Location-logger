//
//  MapController.swift
//  LocationLogger
//
//  Created by Niar on 7/10/17.
//  Copyright © 2017 Niar. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps

class MapController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: GMSMapView!
    
    @IBOutlet var weatherView: UIView!
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self

        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 10)
        mapView.animate(to: camera)
        
        self.locationManager.stopUpdatingLocation()
        
        placeMarker(location: location!)
    }
    
    func placeMarker(location: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemark, error) in
            if error != nil {
                print("Error: \(error)")
            } else {
                var weatherData:String = ""
                
                if let place = placemark?[0] {
                    //let addressString =
                    var addressString : String = "Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude) \n"
                    
                    if place.subLocality != nil {
                        addressString = addressString + place.subLocality! + ", "
                    }
                    if place.thoroughfare != nil {
                        addressString = addressString + place.thoroughfare! + ", "
                    }
                    if place.locality != nil {
                        
                        WeatherManager.sharedInstance.checkWeather(city: place.locality!, completion: { (response) in
                            if let current = response["current"] as? [String : AnyObject] {
        
                                if let temp = current["temp_c"] as? Int {
                                    weatherData += "Temperature: " + String(temp) + " "
                                }
                                if let condition = current["condition"] as? [String : AnyObject] {
                                    weatherData += condition["text"] as! String
                                }
                            }
                            
                            if let error = response["error"] {
                                print("JSON Error: \(error)")
                            }
                            
                            addressString = addressString + place.locality! + ", "
                            
                            if place.country != nil {
                                addressString = addressString + place.country! + ", "
                            }
                            if place.postalCode != nil {
                                addressString = addressString + place.postalCode! + "\n"
                            }
                            if weatherData != "" {
                                addressString = addressString + weatherData
                            }
                            
                            let date = Date()
                           // print(date)
                            CoreDataManager.sharedInstance.save(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, city: place.locality!, date: date, snippet: addressString)
                            
                            DispatchQueue.main.async{
                                self.placeMarker(lat: location.coordinate.latitude, lon: location.coordinate.longitude, text: addressString)
                            }
                            
                        })
                    }
                }
            }
        })
    }
    
    func placeMarker(lat: Double, lon: Double, text: String) {
        
        let marker = GMSMarker()
        //marker.
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.title = "You are here."
        marker.snippet = text
        marker.map = self.mapView
        
        self.mapView.selectedMarker = marker
        
    }
    
}
