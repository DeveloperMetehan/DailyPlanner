//
//  HomeViewModel.swift
//  ToDoListApp1
//
//  Created by Talip on 8.02.2023.
//

import Foundation

final class HomeViewModel {
    var todoList = [Todo]()
    
    private let database: DataBaseProtocol
    
    init(database: DataBaseProtocol = CoreDataManager.shared) {
        self.database = database
    }
    
    func getTodoList() {
        database.fetchAll(entityType: Todo.self) { result in
            switch result {
            case .success(let list):
                self.todoList = list
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func findCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}
