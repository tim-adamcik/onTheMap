//
//  LoginViewController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/12/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var udacityDict: [String:String]?
    var username: String
    var password: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        if emailTextField.text!.isEmpty, passwordTextField.text!.isEmpty  {
            let alert = UIAlertController(title: "Error", message: "Please enter username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        OTMClient.handleLoginRequest(emailTextField.text!, passwordTextField.text!) { (success, error) in
            DispatchQueue.main.async {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.username = self.emailTextField.text!
                self.password = self.passwordTextField.text!
                self.udacityDict = [self.emailTextField.text! : self.passwordTextField.text!]
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabVC")
                vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let url = URL(string: "www.udacity.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

