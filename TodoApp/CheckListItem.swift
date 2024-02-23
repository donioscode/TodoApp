//
//  CheckListItem.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 17/02/24.
//

import Foundation

class CheckListItem: NSObject,Codable {
    var text = ""
    var checked = false
    
    init(text: String , checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
     override  init() {
        
    }
}


class CheckList: NSObject, Codable{
    var name = ""
    var items: [CheckListItem] = []
    init(name: String ) {
        self.name = name
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
