//
//  TaskUtility.swift
//  Taskly
//
//  Created by Vincent Angelo on 26/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

class TaskUtility {
    
    private static let key = "tasks"
    
    // archive
    private static func archive(_ task: [[Task]]) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: task, requiringSecureCoding: false)
    }
    
    // fetch
    
    static func fetch() -> [[Task]]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [[Task]] ?? [[]]
        
    }
    
    // save
    
    static func save (_ task: [[Task]]) {
        // Archive
        let archivedTask = archive(task)
        
        // Set Object for key
        
        UserDefaults.standard.set(archivedTask, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
