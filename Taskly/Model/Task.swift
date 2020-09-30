//
//  Task.swift
//  Taskly
//
//  Created by Vincent Angelo on 25/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

class Task: Codable{
    
    var name: String?
    var isDone: Bool?
    
    private let nameKey = "name"
    private let isDoneKey = "isDone"
    
    init(name: String, isDone: Bool = false) {
        self.name = name
        self.isDone = isDone
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: nameKey)
        coder.encode(isDone, forKey: isDoneKey)
    }
    
    required init?(coder: NSCoder) {
        
        guard let name = coder.decodeObject(forKey: nameKey) as? String,
            let isDone = coder.decodeObject(forKey: isDoneKey) as? Bool else { return }
        
        self.name = name
        self.isDone = isDone
    }
    
    
}
