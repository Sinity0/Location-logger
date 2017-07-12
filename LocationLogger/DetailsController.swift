//
//  DetailsController.swift
//  LocationLogger
//
//  Created by Niar on 7/11/17.
//  Copyright © 2017 Niar. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailsController: UIViewController {

    @IBOutlet var gmapView: GMSMapView!
    private var data: Locations?

    func populateWithData (data: Locations) {
        self.data = data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: (data?.latitude)!, longitude: (data?.longitude)!, zoom: 10.0)
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = map

        placeMarker(mapView: map, lat: (data?.latitude)!, lon: (data?.longitude)!, text: (data?.snippet)!, date: Utils.formatDate(date: (data?.date)! as Date))
    }
    
    func placeMarker(mapView: GMSMapView, lat: Double, lon: Double, text: String, date: String) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.title = "You was here. (\(date))"
        marker.snippet = text
        marker.map = mapView
        
        mapView.selectedMarker = marker
    }
}
