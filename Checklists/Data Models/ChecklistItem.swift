//
//  ChecklistItem.swift
//  Checklists
//
//  Created by IJke Botman on 09/11/2017.
//  Copyright © 2017 Overscope. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    //Set itemID
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    //Schedules notifications by removing existing notification and setting a new one.
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default()
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("Scheduled: \(request) for itemID: \(itemID)")
        }
    }
    
    //Remove notification with itemID
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    //Remove notification if ChecklistItem is deleted
    deinit {
        removeNotification()
    }
}
