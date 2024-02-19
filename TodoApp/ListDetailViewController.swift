//
//  ListDetailViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 19/02/24.
//

import UIKit

protocol ListDetailViewControllerDelegate : AnyObject {
    func listDetailViewController(_ controller: ListDetailViewController,didFinishAdding checkList: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController,didFinishEditing checkList: CheckList)
}

class ListDetailViewController: UITableViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate : ListDetailViewControllerDelegate?
    var itemToEdit: CheckList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        doneButton.isEnabled = false
        
        if let itemToEdit = itemToEdit {
            title = "Edit Item"
            textField.text = itemToEdit.name
            doneButton.isEnabled = true
        }
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        if let itemToEdit = itemToEdit {
            
            itemToEdit.name = textField.text!
            delegate?.listDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
            
            let item = CheckList(name: textField.text!)
            delegate?.listDetailViewController(self, didFinishAdding: item)
        }
    }
}

extension ListDetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        
        let stringRange = Range(range,in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            doneButton.isEnabled = false
        }else{
            doneButton.isEnabled = true
        }
        
        return true
    }
    
}
