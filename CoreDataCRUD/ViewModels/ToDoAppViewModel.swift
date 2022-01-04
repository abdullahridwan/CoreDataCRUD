//
//  ToDoAppViewModel.swift
//  CoreDataCRUD
//
//  Created by Abdullah Ridwan on 1/2/22.
//

import Foundation
import CoreData

enum Priority: String, CaseIterable {
    case all
    case low
    case medium
    case high
}

struct ToDoViewModel {
    //Base info from database
    var todo: ToDoItem
    var id: NSManagedObjectID {
        return todo.objectID
    }
    
    var title: String {
        return todo.title ?? "No title"
    }
    
    var info : String {
        return todo.info ?? "No Info"
    }
    
    var createdDate: Date {
        return todo.createdDate ?? Date()
    }
    
    var modifiedDate: Date {
        return todo.modifiedDate ?? Date()
    }
}

struct NewToDo {
    var title: String
    var info: String
    var createdDate: Date
    var modifiedDate: Date
}

class ToDoAppViewModel: ObservableObject {
    @Published var allTasks: [ToDoViewModel] = [] //unprioiritized ones will stay here as well
    @Published var lowTasks : [ToDoViewModel] = []
    @Published var mediumTasks : [ToDoViewModel] = []
    @Published var highTasks : [ToDoViewModel] = []
    
    func saveTodo(td: NewToDo){
        let newToDo = ToDoItem(context: CoreDataManager.shared.viewContext)
        newToDo.title = td.title
        newToDo.info = td.info
        newToDo.modifiedDate = td.modifiedDate
        newToDo.createdDate = td.createdDate
        CoreDataManager.shared.save()
    }
    func getAllToDos(){
        allTasks = CoreDataManager.shared.getAllToDo().map(ToDoViewModel.init)
    }
    func updateTodo(tdvm: ToDoViewModel){
        //given the id of the todo, update the values.
    }
    func deleteTodo(todo: ToDoViewModel){
        //get the todo by the id
        let existingToDo = CoreDataManager.shared.getToDoByID(tid: todo.id)
        //if it exists, then delete it from the context
        if let existingToDo = existingToDo {
            CoreDataManager.shared.deleteToDo(t: existingToDo)
        }
    }
}
