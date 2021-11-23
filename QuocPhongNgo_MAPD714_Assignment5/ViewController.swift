/**
 * Assignment 4
 * File Name:    ViewController.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Created:   November 12th, 2021
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let tasks = [
        ["Name":"Clean room","DueDate":"November 14, 2021"],
        ["Name":"Wipe floor","DueDate":"November 15, 2021"],
        ["Name":"Water plant","DueDate":"November 16, 2021"],
        ["Name":"Vacuum carpets","DueDate":"November 17, 2021"],
        ["Name":"Dust furniture","DueDate":"November 18, 2021"],
        ["Name":"Spot clean cabinet fronts","DueDate":"November 19, 2021"],
        ["Name":"Clean kitchen table","DueDate":"November 20, 2021"]
    ]
    let tableIdentifier = "tasksTable"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableIdentifier)
    }
      
}

extension ViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Step 1 - Instantiate an object of type UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as! CustomTableViewCell
        let rowData = tasks[indexPath.row]
        cell.name = rowData["Name"]!
        if(indexPath.row < 2)
        {
            cell.backgroundColor = UIColor.systemGray5
            cell.dueDate = "Completed"
        }
        
        //let editImage = UIImage(systemName: "square.and.pencil")
        //cell.imageView?.image = editImage

        // Add Edit button target (add target only once when the cell is created)
        cell.editButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        cell.editButton.tag = indexPath.row
        
        // switch view
//        let switchView = UISwitch(frame: .zero)
//        switchView.setOn(false, animated: true)
//        switchView.tag = indexPath.row
//        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
//        cell.accessoryView = switchView
                
        return cell
    }
    
    /**
     * Selector for pressing button Edit
     */
    @objc func pressButton(_ sender: UIButton) {
         //Somehow get the IndexPath of the row whose button called this function
        // print("Task is \(tasks[sender.tag])")
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /**
     * Selector for changing value of switch 'Due Date'
     */
    @objc func switchChanged(_ sender: UISwitch)
    {
        // get indexPath for current cell
        if let indexPath = self.tableView.indexPathForSelectedRow
        {
            let cell = self.tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            let rowData = tasks[sender.tag]
            if(sender.isOn)
            {
                cell.dueDate = rowData["DueDate"]!
            } else {
                cell.dueDate = ""
            }
            self.tableView.cellForRow(at: indexPath)
        }
    }
}
