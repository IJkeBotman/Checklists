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
    
    init(name: String) {
        self.name = name
        super.init()
    }

}
