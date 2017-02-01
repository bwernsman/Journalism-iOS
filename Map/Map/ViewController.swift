//
//  ViewController.swift
//  Map
//
//  Created by Ben Wernsman on 1/31/17.
//  Copyright © 2017 benwernsman. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var headerView: UIView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make sure that the menu bar settings are still easy to see
        headerView.alpha = 0.8
        
        //Add add Austin pin
        let austin = MKPointAnnotation()
        austin.coordinate = CLLocationCoordinate2DMake(30.25, -97.75)
        austin.title = "Austin"
        mapView.addAnnotation(austin)
        
        //Add UT Tower Pin Pin
        let utTower = MKPointAnnotation()
        utTower.coordinate = CLLocationCoordinate2DMake(30.2862176, -97.739388)
        utTower.title = "UT Tower"
        mapView.addAnnotation(utTower)
        
        isAuthorizedtoGetUserLocation()
        
        //If user enabled location, get it
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    //if we have no permission to access user location, then ask user for permission.
    func isAuthorizedtoGetUserLocation() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    //this method will be called each time when a user change his location access preference.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed location")

            locationManager.requestLocation()
        }
    }
    
    //Called from "requestLocation()"
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called")
        
        mapView.showsUserLocation = true
        
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: locations[0].coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

