//
//  TaskView.swift
//  WatchToDoListApp WatchKit Extension
//
//  Created by Ramill Ibragimov on 12.07.2022.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    
    var body: some View {
        Text(task.text)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: Task(text: "test", id: UUID()))
    }
}
