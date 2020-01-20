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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locations: StudentLocationResponse!
        let dictionary: [String:Any] = locations!.results
        var annotations = [MKPointAnnotation]()
           
    }
   
    
    
    
    @IBAction func pinBtnPressed(_ sender: Any) {
    }
    
    @IBAction func refreshBtnPressed(_ sender: Any) {
    }
}
