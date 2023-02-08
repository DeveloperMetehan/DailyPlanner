//
//  Todo.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 18.01.2023.
//

import Foundation
import CoreData

@objc(Todo)
class Todo: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var detail_description: String
    @NSManaged var date: String
    
    
}
