//
//  DataModel.swift
//  Checklists
//
//  Created by IJke Botman on 11/12/2017.
//  Copyright © 2017 Overscope. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [Checklist]()
    
    //Set the index of last viewed list, this allows the user to go to the list after quitting the app.
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
    }
    
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    //Path to documents directory
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //Path to data stored on device
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    //Save checklists to dataFilePath
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
    
    //Load checklists from dataFilePath
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
                sortChecklists()
            } catch {
                print("Error decoding item array!")
            }
        }
    }
    
    //First time user, create empty list and transition to that list.
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    //Set UserDefaults
    func registerDefaults() {
        let dictionary: [String:Any] = [ "ChecklistIndex": -1, "FirstTime": true ]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    //Sort the checklists alphabetically
    func sortChecklists() {
        lists.sort(by: { checklist1, checklist2 in
            return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending
        } )
    }
    
    //Create new ID number for checklist.
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
 
}
