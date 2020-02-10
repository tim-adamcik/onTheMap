//
//  AddLocationViewController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 2/1/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        searchBar.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    
    @IBAction func addLinkButton(_ sender: Any) {
        let searchBarText = searchBar.text
        if searchBarText == "" {
            let alert = UIAlertController(title: "Error", message: "Please search for a location", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
        let vc = storyboard?.instantiateViewController(identifier: "AddLinkViewController") as! AddLinkViewController
        vc.currentLatitude = self.latitude
        vc.currentLongitude = self.longitude
        vc.currentMapString = self.mapString
        present(vc, animated: true)
        }
    }
    
}



extension AddLocationViewController: UISearchBarDelegate, CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    fileprivate func addPinAndZoomToLocationCoordinates(lat: CLLocationDegrees, lon: CLLocationDegrees, title: String) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
        self.mapView.addAnnotation(annotation)
        
        let coordinate = CLLocationCoordinate2DMake(lat, lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let mapView = mapView,
            let searchBarText = searchBar.text else { return }
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBarText
        searchRequest.region = mapView.region
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if response == nil {
                print("Error: \(error?.localizedDescription ?? "Unknown Error").")
            } else {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                if let lat = response?.boundingRegion.center.latitude,
                    let lon = response?.boundingRegion.center.longitude {
                    self.latitude = lat
                    self.longitude = lon
                    self.mapString = searchBarText
                    self.addPinAndZoomToLocationCoordinates(lat: lat, lon: lon, title: searchBarText)
            
                }
            }
        }
    }
    
}
