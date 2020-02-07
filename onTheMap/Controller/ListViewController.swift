//
//  ListViewController.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/13/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        refreshStudentTable()
    }
    
    
    func refreshStudentTable() {
        _ = OTMClient.getStudents(completion: { (students, error) in
                  StudentModel.students = students
                  DispatchQueue.main.async {
                      self.listTableView.reloadData()
                  }
              })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func pintBtnPressed(_ sender: Any) {
        let alertVC = UIAlertController(title: "Override", message: "Creating a new pin will erase existing pin", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Continue", style: .default, handler: { alert in
            let vc = self.storyboard?.instantiateViewController(identifier: "AddLocationNC") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true)
    }
    
    @IBAction func refreshBtnPressed(_ sender: Any) {
       refreshStudentTable()
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StudentModel.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell")!
        
        let student = StudentModel.students[indexPath.row]
        cell.textLabel?.text = student.firstName + " " + student.lastName
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = StudentModel.students[indexPath.row]
        guard let url = URL(string: student.mediaURL) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
}
