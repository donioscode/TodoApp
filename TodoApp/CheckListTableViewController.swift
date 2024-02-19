//
//  CheckListTableViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 17/02/24.
//

import UIKit

class CheckListTableViewController: UITableViewController , ItemDetailViewControllerDelegate {
    
    var listOfCheckItems = [
        CheckListItem(text: "Row at 0" , checked: false),
        CheckListItem(text: "Row at 1" , checked: false),
        CheckListItem(text: "Row at 2" , checked: false),
        CheckListItem(text: "Row at 3" , checked: false),
        CheckListItem(text: "Row at 4" , checked: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        loadCheckListItems()

    }
    
    @IBAction func addItem() {
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "addItemView" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "editItemView" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
             
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = listOfCheckItems[indexPath.row]
            }
        }
    }
    
    func addItemVCDone(_ vc: ItemDetailViewController, didFinishAdding item: CheckListItem) {
        
        let newRowIndex = listOfCheckItems.count
        
        listOfCheckItems.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
        navigationController?.popViewController(animated: true)
    }
    
    func addItemVCDone(_ vc: ItemDetailViewController, didFinishEditing item: CheckListItem) {
        if let index = listOfCheckItems.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        saveChecklistItems()
        navigationController?.popViewController(animated: true)
    }
    
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCheckItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistitem", for: indexPath)
      
        let item = listOfCheckItems[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckMark(for: cell, with: item)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = listOfCheckItems[indexPath.row]
            item.checked.toggle()
            configureCheckMark(for: cell, with: item)
        }
        saveChecklistItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureText(for cell:UITableViewCell,with item: CheckListItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheckMark(for cell: UITableViewCell,with item: CheckListItem){
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "✅"
        }else{
            label.text = ""
        }

    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        listOfCheckItems.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
    }

}

extension CheckListTableViewController {
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
            let data = try! encoder.encode(listOfCheckItems)
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
                listOfCheckItems = try decoder.decode([CheckListItem].self, from: data)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
