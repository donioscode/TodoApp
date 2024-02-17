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

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        return cell
    }

}
