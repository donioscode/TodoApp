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
        loadCheckListItems()
        title = "Check List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            let controller = segue.destination as! CheckListTableViewController
            controller.checklist = sender as? CheckList
        } else if segue.identifier == "showAddCheckList" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
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
        
        cell.imageView?.image = UIImage(named: checkItem.iconName)
        cell.textLabel?.text = checkItem.name
        cell.detailTextLabel?.text = "\(checkItem.countUncheckedItems())"
        cell.accessoryType = .detailDisclosureButton
        
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = list[indexPath.row]
        
        performSegue(withIdentifier: "showCheckList", sender: checklist)
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self
        let checklist = list[indexPath.row]
        controller.itemToEdit = checklist
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension AllListViewController: ListDetailViewControllerDelegate {
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checkList: CheckList) {
        let newRowIndex = list.count
        
        list.append(checkList)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)

    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checkList: CheckList) {
        if let index = list.firstIndex(of: checkList){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel?.text = checkList.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
}

extension AllListViewController {
    func documentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths.first
    }
    
    func dataFilePath() ->URL {
        return documentsDirectory()!.appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
        let encoder  = PropertyListEncoder()
        
        do {
            let data = try! encoder.encode(list)
            try data.write(to: dataFilePath(),options: Data.WritingOptions.atomic)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func loadCheckListItems() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            
            do {
                list = try decoder.decode([CheckList].self, from: data)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}

