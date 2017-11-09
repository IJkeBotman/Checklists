//
//  ChecklistItem.swift
//  Checklists
//
//  Created by IJke Botman on 09/11/2017.
//  Copyright © 2017 Overscope. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
