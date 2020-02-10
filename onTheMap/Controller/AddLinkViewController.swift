//
//  AddLinkViewController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 2/5/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class AddLinkViewController: UIViewController, UITextFieldDelegate {
    
    var currentLatitude: Double?
    var currentLongitude: Double?
    var currentMapString: String?
    var currentmediaURL: String = ""
    
    
    @IBOutlet weak var linkLabel: UILabel!
    
    @IBOutlet weak var enterLinkTextField: UITextField!
    
    
    
//    let post = StudentLocation(latitude: <#T##Double#>, longitude: <#T##Double#>, mapString: currentMapString, mediaURL: "www.udacity.com", objectId: OTMClient.Auth.id, uniqueKey: OTMClient.Auth.key)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func submitBtn(_ sender: Any) {
    }
    
    
}
