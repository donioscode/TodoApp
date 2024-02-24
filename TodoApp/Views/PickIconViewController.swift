//
//  PickIconViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 24/02/24.
//

import UIKit

protocol PickIconViewControllerDelegate: AnyObject {
    func iconPicker (_ picker: PickIconViewController,didPick iconName: String )
}


class PickIconViewController: UITableViewController {

    
    weak var delegate: PickIconViewControllerDelegate?
    var icons = ["plans","phone","user","smartphone","school","laptop","increase","home","gym","education","clock","business-goal","beach"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell",  for: indexPath)
        
        let iconName = icons[indexPath.row]
        cell.textLabel?.text = iconName
        cell.imageView?.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.iconPicker(self, didPick: icons[indexPath.row])
    }
}
