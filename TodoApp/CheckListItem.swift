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


class CheckList: NSObject {
    var name = ""
    
    init(name: String ) {
        self.name = name
        super.init()
    }
}
