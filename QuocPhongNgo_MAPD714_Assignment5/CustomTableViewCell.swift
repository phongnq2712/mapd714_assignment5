/**
 * Assignment 5
 * File Name:    CustomTableViewCell.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Created:   November 25th, 2021
 */

import UIKit
import FirebaseDatabase

class CustomTableViewCell: UITableViewCell {
    
    let ref = Database.database().reference(withPath: "todo-list")
    var refObservers: [DatabaseHandle] = []

    weak var editButton: UIButton!
    
    var name:String = "" {
        didSet {
            if(name != oldValue) {
                nameLabel.text = name
            }
        }
    }
    var dueDate:String = "" {
        didSet {
            if(dueDate != oldValue)
            {
                dueDateLabel.text = dueDate
            }
        }
    }
    var nameLabel: UILabel!
    var dueDateLabel: UILabel!
    var switchUI: UISwitch!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // add a new subview for the new label
        //let nameLabelRect = CGRect(x:0, y:5, width: 70, height: 15)
        //let nameMarker = UILabel(frame: nameLabelRect)
        //nameMarker.textAlignment = NSTextAlignment.right
        //nameMarker.text = "Movie Name:"
        //nameMarker.font = UIFont.boldSystemFont(ofSize: 12)
        //contentView.addSubview(nameMarker)
        
        // add a new subview for the new label
        //let genreLabelRect = CGRect(x:0, y:26, width: 70, height: 15)
        //let genreMarker = UILabel(frame: genreLabelRect)
        //genreMarker.textAlignment = NSTextAlignment.right
        //genreMarker.text = "Genre Name:"
        //genreMarker.font = UIFont.boldSystemFont(ofSize: 12)
        //contentView.addSubview(genreMarker)
        
        let nameValueRect = CGRect(x:80, y:0, width: 200, height: 40)
        nameLabel = UILabel(frame: nameValueRect)
        contentView.addSubview(nameLabel)
        
        let genreValueRect = CGRect(x:80, y:16, width: 200, height: 40)
        dueDateLabel = UILabel(frame: genreValueRect)
        contentView.addSubview(dueDateLabel)
        
        //Initialize Edit button
        let editButton = UIButton(frame: CGRect(x: 8, y: 4.5, width: 48, height: 28))
        self.editButton = editButton
        self.frame = frame
        
        //Setup Edit button
        addSubview(editButton)
        let editImage = UIImage(systemName: "square.and.pencil")
        editButton.setImage(editImage, for: UIControl.State.normal)
        editButton.setTitleColor(.blue, for: .normal)
        editButton.center.y = self.center.y
        //switch view
        switchUI = UISwitch(frame: CGRect(x: 320, y: 5, width: 30, height: 15))
        switchUI.isEnabled = true
        switchUI.isOn = true
        switchUI.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        contentView.addSubview(switchUI)
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        //let rowData = tasks[sender.tag]
        if (sender.isOn) {
            dueDate = "ON"
        }
        else{
            dueDate = "OFF"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
