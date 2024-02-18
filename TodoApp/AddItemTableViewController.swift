//
//  AddItemTableViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 18/02/24.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var addItemTF: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBarButton.isEnabled = false
        addItemTF.delegate = self
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addItemTF.becomeFirstResponder()
    }
    
    @IBAction func done(){
        navigationController?.popViewController(animated: true)
    
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
