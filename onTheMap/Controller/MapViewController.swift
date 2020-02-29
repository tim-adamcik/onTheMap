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
        mapView.delegate = self
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifer = "idForView"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifer) as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifer)
            view!.canShowCallout = true
            view!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return view
        } else {
            view!.annotation = annotation
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let subtitle = view.annotation?.subtitle as? String {
            guard let url = URL(string: subtitle) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    
    
    @IBAction func pinBtnPressed(_ sender: Any) {
        let alertVC = UIAlertController(title: "Add a pin", message: "Creating a new pin will erase any existing pin", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Continue", style: .default, handler: { alert in
            let vc = self.storyboard?.instantiateViewController(identifier: "AddLocationViewController") as! AddLocationViewController
            self.present(vc, animated: true, completion: nil)
            }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true)
    }
    
    @IBAction func refreshBtnPressed(_ sender: Any) {
        reloadMap()
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        OTMClient.deleteSession { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertVC, animated: true)
                    return
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
