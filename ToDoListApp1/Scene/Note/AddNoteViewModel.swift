//
//  AddNoteViewModel.swift
//  ToDoListApp1
//
//  Created by Talip on 8.02.2023.
//

import Foundation

protocol NoteViewModel {
    func didClickSaveButton(name: String, detailDescription: String)
}

final class AddNoteViewModel: NoteViewModel {
    private let database: DataBaseProtocol
    
    init(database: DataBaseProtocol = CoreDataManager.shared) {
        self.database = database
    }
    
    func didClickSaveButton(name: String, detailDescription: String) {
        let newNote = Todo(name: name, detailDescription: detailDescription, date: Date())
        database.insert(entity: newNote)
    }
    
}
