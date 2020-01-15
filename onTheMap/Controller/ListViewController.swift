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
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = OTMClient.taskForGetRequest(completion: { (students, error) in
            StudentModel.students = students
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        })
        listTableView.delegate = self
        listTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listTableView.reloadData()
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
        cell.textLabel?.text = student.firstName + student.lastName
        
        return cell
    }
    
}
