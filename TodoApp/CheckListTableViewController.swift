//
//  CheckListTableViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 17/02/24.
//

import UIKit

class CheckListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    var listOfCheckItems = [
        CheckListItem(text: "Row at 0" , checked: false),
        CheckListItem(text: "Row at 1" , checked: false),
        CheckListItem(text: "Row at 2" , checked: false),
        CheckListItem(text: "Row at 3" , checked: false),
        CheckListItem(text: "Row at 4" , checked: false)
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCheckItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistitem", for: indexPath)
        
        
        let label = cell.viewWithTag(1000) as! UILabel
        let item = listOfCheckItems[indexPath.row]
        
        label.text = item.text
        
        if  item.checked {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            var item = listOfCheckItems[indexPath.row]
            item.checked.toggle()
            
            if item.checked {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
