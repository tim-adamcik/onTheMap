//
//  DropPinController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/20/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class DropPinController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
    }
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
  
    @IBOutlet weak var enterLocationTextField: UITextField!
    
    
    @IBAction func findOnMapBtn(_ sender: Any) {
    }
}
