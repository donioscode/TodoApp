//
//  AddItemTableViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 18/02/24.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
    }
    
    @IBAction func done(){
        navigationController?.popViewController(animated: true)
    }
}
