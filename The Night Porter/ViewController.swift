//
//  ViewController.swift
//  The Night Porter
//
//  Created by esat taha ibis on 2019-05-31.
//  Copyright © 2019 Esat Ibis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var dailyTasks = [Task(name: "Check All windows", type: .daily, completed: false, lastCompleted: nil),
                      Task(name: "Check All Windows", type: .daily, completed: false, lastCompleted: nil),
                      Task(name: "Is the boiler fueled?", type: .daily, completed: false, lastCompleted: nil),
                      Task(name: "Check The mailbox", type: .daily, completed: false, lastCompleted: nil),
                      Task(name: "Empty the trash containers", type: .daily, completed: false, lastCompleted: nil),
                      Task(name: "If freezing, check the water pipes", type: .daily, completed: false, lastCompleted: nil),
                      Task(name: "Document \"strange and unusual\" occurences", type: .daily, completed: false, lastCompleted: nil),
                      ]
    
    var weeklyTasks = [Task(name: "Check inside the all cabins", type: .weekly, completed: false, lastCompleted: nil),
                       Task(name: "Flush all lavatories in the cabins", type: .weekly, completed: false, lastCompleted: nil),
                       Task(name: "Walk the perimiter of the property", type: .weekly, completed: false, lastCompleted: nil),
                        ]
    
    var monthlyTasks = [Task(name: "Test the security alarm", type: .monthly, completed: false, lastCompleted: nil),
                        Task(name: "Test the motion detectors", type: .monthly, completed: false, lastCompleted: nil),
                        Task(name: "Test smoke alarms", type: .monthly, completed: false, lastCompleted: nil),
                        ]
    
    @IBAction func changeDarkMode(_ sender: Any) {
        let darkModeSwitch = sender as! UISwitch
        
        if darkModeSwitch.isOn {
            view.backgroundColor = UIColor.darkGray
        } else {
            view.backgroundColor = UIColor.white
        }
        
    }
    
    @IBAction func resetTheList(_ sender: Any) {
        
        let confirm = UIAlertController(title: "Are You Sure?", message: "Do you want to reset the list?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            for i in 0..<self.dailyTasks.count {
                self.dailyTasks[i].completed = false
            }
            
            for i in 0..<self.weeklyTasks.count {
                self.weeklyTasks[i].completed = false
            }
            
            for i in 0..<self.monthlyTasks.count {
                self.monthlyTasks[i].completed = false
            }
            
            self.taskTableView.reloadData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            print("That was a close one")
        }
        // add actions to the alert
        confirm.addAction(yesAction)
        confirm.addAction(noAction)
        
        // show the alert
        present(confirm, animated: true, completion: nil)
    }
    
    // Table view delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row \(indexPath.row) in  the section \(indexPath.section)")
    }
    
    // Completed action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") {
            (action: UIContextualAction, sourceView: UIView,
            actionPerformed: (Bool) -> Void) in
            
            switch(indexPath.section) {
            case 0:
                self.dailyTasks[indexPath.row].completed = true
            case 1:
                self.weeklyTasks[indexPath.row].completed = true
            case 2:
                self.monthlyTasks[indexPath.row].completed = true
            default:
                break
            }
            // refresh data after the dataset is changed
            tableView.reloadData()
            
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let notCompletedAction = UIContextualAction(style: .destructive, title: "Not Completed") { (_, _, actionPerformed: (Bool) -> Void) in
            
            switch(indexPath.section) {
            case 0:
                self.dailyTasks[indexPath.row].completed = false
            case 1:
                self.weeklyTasks[indexPath.row].completed = false
            case 2:
                self.monthlyTasks[indexPath.row].completed = false
            default:
                break
            }
            // refresh data after the dataset is changed
            tableView.reloadData()
            
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [notCompletedAction])
    }
    
    // Table view data source methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = UIColor.clear
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Daily Tasks"
        case 1:
            return "Weekly Tasks"
        case 2:
            return "Monthly Tasks"
        default:
            return "Unknown"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dailyTasks.count
        case 1:
            return weeklyTasks.count
        case 2:
            return monthlyTasks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        
        var currentTask: Task?
        
        switch indexPath.section {
        case 0:
            currentTask = dailyTasks[indexPath.row]
        case 1:
            currentTask = weeklyTasks[indexPath.row]
        case 2:
            currentTask = monthlyTasks[indexPath.row]
        default:
            break
        }
        
        if let unwrappedTask = currentTask {
            cell.textLabel?.text = unwrappedTask.name
            if unwrappedTask.completed {
                cell.textLabel?.textColor = UIColor.lightGray
                cell.accessoryType = .checkmark
            } else {
                cell.textLabel?.textColor = UIColor.black
                cell.accessoryType = .none
            }
        }
        
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

