//
//  CoreDataManager.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 18.01.2023.
//

import Foundation
import CoreData


final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer.init(name: "ToDoListApp1")
        container.loadPersistentStores { (description, error ) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    //veri çekmeyi sağlar.
    func fetch() -> [Todo] {
        var result = [Todo]()
        
        let fetchRequest = NSFetchRequest<Todo>.init(entityName: "Todo")
        do {
          result = try container.viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
       return result
    }
    //kaydedilecek değerler için parametre oluşturup o parametleri databasedeki(Todo) tablonun attributesları ile eşleştirdik.
    func insert(name: String,detail_description: String, date: String) -> Todo {
        let todo = Todo.init(context: container.viewContext)
        todo.name = name
        todo.detail_description = detail_description
        todo.date = date
        return todo
    }
    //coredataya kaydetmeyi sağlayacak fonksiyon.
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

