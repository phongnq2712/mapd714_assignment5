/**
 * Assignment 5
 * File Name:    ViewController.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Created:   November 12th, 2021
 */

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let ref = Database.database().reference()
    private var tasks: [Todo] = [
//        ["Name":"Clean room","DueDate":"November 14, 2021"],
//        ["Name":"Wipe floor","DueDate":"November 15, 2021"],
//        ["Name":"Water plant","DueDate":"November 16, 2021"],
//        ["Name":"Vacuum carpets","DueDate":"November 17, 2021"],
//        ["Name":"Dust furniture","DueDate":"November 18, 2021"],
//        ["Name":"Spot clean cabinet fronts","DueDate":"November 19, 2021"],
//        ["Name":"Clean kitchen table","DueDate":"November 20, 2021"]
        
    ]
    let tableIdentifier = "tasksTable"
    
    func loadData() {
        var flag = true
        // load table view
        ref.observe(.value) { snapshot in
            // 2
            var newItems: [String] = []
            // 3
            for child in snapshot.children {
                // 4
                if
                    let snapshot = child as? DataSnapshot,
                    let dataChange = snapshot.value as? [String:AnyObject],
                    let groceryItem =  dataChange["name"] as? String {
                    newItems.append(groceryItem)
                }
            }
            // 5
            while (flag) {
                for i in newItems {
                    self.tasks.append(Todo(name: i))
                }
                self.tableView.reloadData()
                flag = false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        print("didload")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
    
    @objc private func didTapAdd()
    {
        let alert = UIAlertController(title: "New Item", message: "Enter New To Do Item", preferredStyle: .alert)
        alert.addTextField{field in
            field.placeholder = "Enter item"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {[weak self](_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    // enter new to do list item
                    self!.ref.child(text).setValue([
                        "name": text
                    ])
                    DispatchQueue.main.async {
                        let newEntry = [text]
                        UserDefaults.standard.setValue(newEntry, forKey: "")
                        self?.tasks.append(Todo(name: text))
                        self?.tableView.reloadData()
                    }
                }
            }
        }))
        present(alert, animated: true)
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
        //cell.name = rowData["Name"]!
        cell.name = rowData.name
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
                //cell.dueDate = rowData["DueDate"]!
            } else {
                cell.dueDate = ""
            }
            self.tableView.cellForRow(at: indexPath)
        }
    }
}
