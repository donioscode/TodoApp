//
//  CheckListItem.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 17/02/24.
//

import Foundation

class CheckListItem: NSObject,Codable {
    var id = UUID().uuidString
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    
    init(text: String , checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
     override  init() {
        
    }
}


class CheckList: NSObject, Codable{
    var name = ""
    var iconName = "plans"
    var items: [CheckListItem] = []
    
    init(name: String,iconName: String = "plans") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    func countUncheckedItems() -> String  {
        var count = 0
        
        for item in items where !item.checked  {
            count += 1
        }
        if count == 0 {
            return "No items"
        } else {
            return " \(count) Remaing"
        }
    }
}
