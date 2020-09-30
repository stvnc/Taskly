//
//  TaskController.swift
//  Taskly
//
//  Created by Vincent Angelo on 25/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ScheduleCell"

class TaskController: UITableViewController {
    
    // MARK: - Properties
    
    var taskStore = TaskStore(){
        didSet{
            
            // Get Data
            taskStore.tasks = TaskUtility.fetch() ?? [[Task](), [Task]()]
            
            // Reload Table View
            tableView.reloadData()
        }
    }
    
    
    
    
    // MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableView.insetsLayoutMarginsFromSafeArea = false
        
        
        
        
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Selectors
    
    @objc func handleTextChanged(_ sender: UITextField){
        guard let alert = presentedViewController as? UIAlertController,
            let addAction = alert.actions.first,
            let text = sender.text else { return }
        
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    @objc func addTask(_ sender: UIBarButtonItem) {
        print("DEBUG:")
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) {
            _ in
            
            // Grab text field text
            
            guard let taskName  = alert.textFields?.first?.text else { return }
            
            
            
            
            // Create task
            
            let newTask = Task(name: taskName)
            
            
            // Add Task
            
            self.taskStore.addTask(newTask, at: 0)
            
            let indexPath  = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
            TaskUtility.save(self.taskStore.tasks)
            
            
            // Reload data in tableView
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        alert.addTextField { textField in
            textField.placeholder = "Enter task name..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        
        addAction.isEnabled = false
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Helpers
    
    
    
    func configureUI(){
        //        navigationController?.navigationBar.backgroundColor = .systemBlue
        
        view.backgroundColor = .white
        
        navigationItem.title = "Taskly"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        
        tableView.frame = view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        
        
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - DataSource

extension TaskController {
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "To-Do" : "Done"
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskStore.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.tasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ScheduleCell
        cell.textLabel?.text = taskStore.tasks[indexPath.section][indexPath.row].name
        
        return cell
    }
}

// MARK: - Delegate

extension TaskController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
            
            // determine whether the task 'isDone'
            
            guard let isDone = self.taskStore.tasks[indexPath.section][indexPath.row].isDone else { return }
            
            
            
            // Remove the task from the appropriate array
            
            self.taskStore.removeTask(at: indexPath.row, isDone: isDone)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            TaskUtility.save(self.taskStore.tasks)
            // Indicate that the action was performed
            completionHandler(true)
        }
        
        deleteAction.image = #imageLiteral(resourceName: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
       
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
            // Toggle that the task is done
            
            self.taskStore.tasks[0][indexPath.row].isDone = true
            
            // Remove the task from the array containing todo tasks
            
            let doneTask = self.taskStore.removeTask(at: indexPath.row)
            
            // Reload table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Add the task to the array containing done task
            self.taskStore.addTask(doneTask, at: 0, isDone: true)
            
            
            // Reload table view
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            
            TaskUtility.save(self.taskStore.tasks)
            
            //Indicate the action was performed
            completionHandler(true)
            
        }
        
        doneAction.image = #imageLiteral(resourceName: "done")
        doneAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil    }
}
