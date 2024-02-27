//
//  CheckListItem.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 17/02/24.
//

import Foundation
import UserNotifications

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
    
    func scheduleNotification(){
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: dueDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger )
        }
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
