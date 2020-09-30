//
//  TaskStore.swift
//  Taskly
//
//  Created by Vincent Angelo on 25/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

class TaskStore {
    
    // Index 0 -> To Do, Index 1 -> Completed
    var tasks = [[Task](), [Task]()]
    
    // add task
    
    func addTask(_ task: Task, at index: Int, isDone: Bool = false) {
        let section = isDone ? 1 : 0
        
        tasks[section].insert(task, at: index)
    }
    
    
    // remove task
    
    @discardableResult func removeTask(at index: Int, isDone: Bool = false) -> Task {
        let section = isDone ? 1 : 0
        
        return tasks[section].remove(at: index)
        
        
    }
    
}
