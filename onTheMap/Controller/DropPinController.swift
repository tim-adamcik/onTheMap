//
//  DropPinController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/20/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class DropPinController: UIViewController, UISearchBarDelegate {
    
  
    @IBOutlet weak var enterLocationTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
    }
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    
    @IBAction func searchTextField(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func findOnMapBtn(_ sender: Any) {
    }
    
}


