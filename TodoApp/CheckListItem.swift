//
//  CheckListItem.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 17/02/24.
//

import Foundation

class CheckListItem: NSObject {
    var text = ""
    var checked = false
    
    init(text: String , checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
     override  init() {
        
    }
}
