//
//  AddItemTableViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 18/02/24.
//

import UIKit

protocol AddItemViewControllerDelegate : AnyObject {
    func addItemVCDone(_ vc: AddItemTableViewController,didFinishAdding item: CheckListItem)
    func addItemVCDone(_ vc: AddItemTableViewController,didFinishEditing item: CheckListItem)
}

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var addItemTF: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate : AddItemViewControllerDelegate?
    var itemToEdit: CheckListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBarButton.isEnabled = false
        addItemTF.delegate = self
        
        if let itemToEdit = itemToEdit {
            title = "Edit Item"
            addItemTF.text = itemToEdit.text
            doneBarButton.isEnabled = true
        }
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addItemTF.becomeFirstResponder()
    }
    
    @IBAction func done(){
        
        if let itemToEdit = itemToEdit {
            itemToEdit.text = addItemTF.text!
            delegate?.addItemVCDone(self, didFinishEditing: itemToEdit)
        } else {
            let item = CheckListItem()
            item.text =  addItemTF.text!
            
            delegate?.addItemVCDone(self, didFinishAdding: item)
        }
    }
}

extension AddItemTableViewController: UITextFieldDelegate {
    
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
