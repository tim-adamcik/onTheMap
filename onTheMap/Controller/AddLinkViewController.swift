//
//  AddLinkViewController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 2/5/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class AddLinkViewController: UIViewController {
    
    var currentLatitude: Double?
    var currentLongitude: Double?
    var currentMapString: String?
    var mediaURL: String = ""
    
    let post = StudentLocation(latitude: <#T##Double#>, longitude: <#T##Double#>, mapString: currentMapString, mediaURL: linkTextField.text, objectId: OTMClient.Auth.id, uniqueKey: OTMClient.Auth.key)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
}
