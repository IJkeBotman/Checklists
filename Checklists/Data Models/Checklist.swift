//
//  Checklist.swift
//  Checklists
//
//  Created by IJke Botman on 10/12/2017.
//  Copyright © 2017 Overscope. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var iconName = "No Icon"
    var items = [ChecklistItem]()
    
    init(name: String, iconName: String = "No Icon") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    //Count of Unchecked items to display in view.
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
//        var count = 0
//        for item in items where !item.checked {
//            count += 1
//        }
//        return count
    }

}
