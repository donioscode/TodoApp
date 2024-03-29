//
//  AddItemTableViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 18/02/24.
//

import UIKit

protocol ItemDetailViewControllerDelegate : AnyObject {
    func addItemVCDone(_ vc: ItemDetailViewController,didFinishAdding item: CheckListItem)
    func addItemVCDone(_ vc: ItemDetailViewController,didFinishEditing item: CheckListItem)
}

class ItemDetailViewController: UITableViewController {

    @IBOutlet weak var addItemTF: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var shouldRemindSwich: UISwitch!
    weak var delegate : ItemDetailViewControllerDelegate?
    var itemToEdit: CheckListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBarButton.isEnabled = false
        addItemTF.delegate = self
        
        if let itemToEdit = itemToEdit {
            title = "Edit Item"
            addItemTF.text = itemToEdit.text
            doneBarButton.isEnabled = true
            shouldRemindSwich.isOn = itemToEdit.shouldRemind
            datePicker.date = itemToEdit.dueDate
        }
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addItemTF.becomeFirstResponder()
    }
    
    @IBAction func shouldRemaindToggled(_ sender: UISwitch) {
        addItemTF.resignFirstResponder()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound]) { _, _ in
            
        }
    }
    @IBAction func done(){
        
        if let itemToEdit = itemToEdit {
            itemToEdit.text = addItemTF.text!
            itemToEdit.shouldRemind = shouldRemindSwich.isOn
            itemToEdit.dueDate = datePicker.date
            
            itemToEdit.scheduleNotification()
            delegate?.addItemVCDone(self, didFinishEditing: itemToEdit)
        } else {
            let item = CheckListItem()
            item.text =  addItemTF.text!
            
            item.scheduleNotification()
            item.shouldRemind = shouldRemindSwich.isOn
            item.dueDate = datePicker.date
            
            delegate?.addItemVCDone(self, didFinishAdding: item)
        }
    }
}

extension ItemDetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        
        let stringRange = Range(range,in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        
        return true
    }
    
}
