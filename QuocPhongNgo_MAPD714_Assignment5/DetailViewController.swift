/**
 * Assignment 5
 * File Name:    DetailViewController.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Created:   November 26th, 2021
 */

import UIKit
import FirebaseDatabase

class DetailViewController: UIViewController {

    @IBOutlet weak var taskName: UITextField!
    var taskNameText: String?
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskName.text = taskNameText
    }

    /**
     * Handling event for Update button
     */
    @IBAction func btnUpdateClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to update?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    /**
     * Handling event for Delete button
     */
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {[weak self](_) in
            // remove a task
            self!.remove(child: self?.taskNameText ?? "")
            // return todo list screen
            if let vc = self?.storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController {                
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }))
        
        present(alert, animated: true)
    }
    
    /**
     * Delete a task
     */
    func remove(child: String) {
        let ref = self.ref.child(child)
        ref.removeValue { error, _ in
            print(error)
        }
    }
}
