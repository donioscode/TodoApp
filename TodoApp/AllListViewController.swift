//
//  AllListViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 19/02/24.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var list = [CheckList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let homeWorks = CheckList(name: "HomeWorks")
        let uni = CheckList(name: "UniversityTasks")
        let homeDuty = CheckList(name: "HomeDuty")
        
   
        list.append(homeWorks)
        list.append(uni)
        list.append(homeDuty)
        
        title = "Check List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            let controller = segue.destination as! CheckListTableViewController
            controller.checklist = sender as? CheckList
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistCell", for: indexPath)
        let checkItem = list[indexPath.row]
        
        cell.textLabel?.text = checkItem.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = list[indexPath.row]
        
        performSegue(withIdentifier: "showCheckList", sender: checklist)
    }
}
