//
//  Task.swift
//  WatchToDoListApp WatchKit Extension
//
//  Created by Ramill Ibragimov on 12.07.2022.
//

import Foundation

struct Task: Identifiable, Codable {
    var text: String
    let id: UUID
}
