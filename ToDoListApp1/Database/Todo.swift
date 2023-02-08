//
//  Todo.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 18.01.2023.
//

import Foundation
import CoreData

@objc(Todo)
class TodoManagedObject: NSManagedObject, DBEntityConvertable {
    @NSManaged var name: String
    @NSManaged var detail_description: String
    @NSManaged var date: Date
    
    func convert() -> DataBaseEntity {
        return Todo(dbId: self.objectID,
                    name: self.name,
                    detailDescription: self.detail_description,
                    date: self.date)
    }
}

class Todo: DataBaseEntity {
    var dbId: NSManagedObjectID?
    var name: String
    var detailDescription: String
    /// Will be timestamp
    var date: Date
    
    init(dbId: NSManagedObjectID? = nil,
         name: String,
         detailDescription: String,
         date: Date) {
        self.dbId = dbId
        self.name = name
        self.detailDescription = detailDescription
        self.date = date
    }
    
    static func getFetchRequest<TodoManagedObject>() -> NSFetchRequest<TodoManagedObject>{
        return NSFetchRequest<TodoManagedObject>(entityName: "Todo")
    }
    
    func insertToDB(context: NSManagedObjectContext) -> Self {
        let newTodo = TodoManagedObject(context: context)
        newTodo.name = self.name
        newTodo.detail_description = self.detailDescription
        newTodo.date = self.date
        self.dbId = newTodo.objectID
        return self
    }
    
    func updateInDb(context: NSManagedObjectContext) -> Self {
        guard let datebaseId = dbId, let updatedTodo = context.object(with: datebaseId) as? TodoManagedObject else { return self }
        updatedTodo.name = self.name
        updatedTodo.detail_description = self.detailDescription
        updatedTodo.date = self.date
        return self
    }
}
