//
//  Task.swift
//  The Night Porter
//
//  Created by esat taha ibis on 2019-06-03.
//  Copyright © 2019 Esat Ibis. All rights reserved.
//

import Foundation

enum TaskType {
    case daily, weekly, monthly
}

struct Task {
    var name: String
    var type: TaskType
    var completed: Bool
    var lastCompleted: NSData?
}
