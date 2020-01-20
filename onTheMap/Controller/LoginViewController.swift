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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabVC")
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
    }
}

