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
    var mediaURL: String = ""
    
    @IBOutlet weak var linkLabel: UILabel!
    
    @IBOutlet weak var enterLinkTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterLinkTextField.delegate = self
        enterLinkTextField.layer.cornerRadius = 5.0
        enterLinkTextField.text = mediaURL
        
    }
    
    func hideKeyboard() {
        enterLinkTextField.resignFirstResponder()
    }
    
    func linkWasEntered() {
        guard let link = enterLinkTextField.text else {
            print("no link was entered")
            return
        }
        enterLinkTextField.text = link
        mediaURL = link
        print(mediaURL)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        hideKeyboard()
        linkWasEntered()
        return true
    }
    
    
    fileprivate func handlePostStudentRequest() {
        let body = StudentLocation(firstName: "Daffy", lastName: "Duck", latitude: currentLatitude!, longitude: currentLongitude!, mapString: currentMapString!, mediaURL: mediaURL, objectId: OTMClient.Auth.id, uniqueKey: OTMClient.Auth.key)
        OTMClient.postStudents(body: body) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                print("Posted successfully")
            }
        }
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        handlePostStudentRequest()
    }
}
