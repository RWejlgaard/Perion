//
//  Perion.swift
//  Perion
//
//  Created by Rasmus Wejlgaard on 05/08/2017.
//  Copyright © 2017 Rasmus Wejlgaard. All rights reserved.
//
import Foundation

class PTypes {
    struct PTask {
        let title : String
        let timeCreated : String
        let dueDate : String
        let importance : String
        init(_title: String, _created : String, _due : String, _importance : String) {
            self.title = _title
            self.timeCreated = _created
            self.dueDate = _due
            self.importance = _importance
        }
    }
}



