//
//  ContentView.swift
//  WatchToDoListApp WatchKit Extension
//
//  Created by Ramill Ibragimov on 12.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var taskText = ""
    @State private var tasks = [Task]()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Task", text: $taskText)
                
                Button {
                    guard taskText.isEmpty == false else { return }
                    let task = Task(text: taskText, id: UUID())
                    tasks.append(task)
                    taskText = ""
                    
                    saveTasks()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .blue))
            }
            
            List {
                ForEach(0..<tasks.count, id: \.self) { i in
                    NavigationLink {
                        TaskView(task: tasks[i])
                    } label: {
                        Text(tasks[i].text)
                            .lineLimit(1)
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocuments() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            let url = getDocuments().appendingPathComponent("tasks")
            
            try data.write(to: url)
        } catch {
            print("Error")
        }
    }
    
    func loadData() {
        DispatchQueue.main.async {
            do {
                let url = getDocuments().appendingPathComponent("tasks")
                let data = try Data(contentsOf: url)
                tasks = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print("Error")
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            tasks.remove(atOffsets: offsets)
            saveTasks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
