//
//  MapViewController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/13/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadMap()
    }
    
    func reloadMap() {
        annotations = []
        mapView.removeAnnotations(mapView.annotations)
        for student in StudentModel.students {
            let annotation = MKPointAnnotation()
            if let lat = CLLocationDegrees(exactly: student.latitude), let lon = CLLocationDegrees(exactly: student.longitude) {
                let coordinateLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                annotation.coordinate = coordinateLocation
                annotation.title = "\(student.firstName) \(student.lastName)"
                annotation.subtitle = student.mediaURL
                annotations.append(annotation)
            }
        }
        mapView.addAnnotations(annotations)
    }
    
    
    
    
    @IBAction func pinBtnPressed(_ sender: Any) {
    }
    
    @IBAction func refreshBtnPressed(_ sender: Any) {
        reloadMap()
    }
}
