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
    let searchController = UISearchController(searchResultsController: nil)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    
    @IBAction func dropPinLocation(_ sender: Any) {
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
            let span = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         guard let mapView = mapView,
                   let searchBarText = searchController.searchBar.text else { return }
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
                           
                           let annotation = MKPointAnnotation()
                           annotation.title = searchBarText
                           annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
                           self.mapView.addAnnotation(annotation)
                           
                           let coordinate = CLLocationCoordinate2DMake(lat, lon)
                           let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                           let region = MKCoordinateRegion(center: coordinate, span: span)
                           self.mapView.setRegion(region, animated: true)
                           
                       }
                   }
               }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let mapView = mapView,
//            let searchBarText = searchController.searchBar.text else { return }
//        let searchRequest = MKLocalSearch.Request()
//        searchRequest.naturalLanguageQuery = searchBarText
//        searchRequest.region = mapView.region
//        let search = MKLocalSearch(request: searchRequest)
//        search.start { (response, error) in
//            if response == nil {
//                print("Error: \(error?.localizedDescription ?? "Unknown Error").")
//            } else {
//                let annotations = self.mapView.annotations
//                self.mapView.removeAnnotations(annotations)
//
//                if let lat = response?.boundingRegion.center.latitude,
//                    let lon = response?.boundingRegion.center.longitude {
//
//                    let annotation = MKPointAnnotation()
//                    annotation.title = searchBarText
//                    annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
//                    self.mapView.addAnnotation(annotation)
//
//                    let coordinate = CLLocationCoordinate2DMake(lat, lon)
//                    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//                    let region = MKCoordinateRegion(center: coordinate, span: span)
//                    self.mapView.setRegion(region, animated: true)
//
//                }
//            }
//        }
    }
    
}
