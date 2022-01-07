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

//struct ToDoViewModel {
//    //Base info from database
//    var todo: ToDoItem
//    var id: NSManagedObjectID {
//        return todo.objectID
//    }
//
//    var title: String {
//        return todo.title ?? "No title"
//    }
//
//    var info : String {
//        return todo.info ?? "No Info"
//    }
//
//    var createdDate: Date {
//        return todo.createdDate ?? Date()
//    }
//
//    var modifiedDate: Date {
//        return todo.modifiedDate ?? Date()
//    }
//}

struct ToDoViewModel {
    //Base info from database
    var todo: ToDoItem
    var id: NSManagedObjectID
    var title: String
    var info : String
    var createdDate: Date
    var modifiedDate: Date
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
    func save(){
        CoreDataManager.shared.save()
    }
    func saveTodo(td: NewToDo){
        let newToDo = ToDoItem(context: CoreDataManager.shared.viewContext)
        newToDo.title = td.title
        newToDo.info = td.info
        newToDo.modifiedDate = td.modifiedDate
        newToDo.createdDate = td.createdDate
        CoreDataManager.shared.save()
    }
    func getAllToDos(){
        allTasks = CoreDataManager.shared.getAllToDo().map{ (ToDoItem) -> ToDoViewModel in
            return ToDoViewModel(todo: ToDoItem, id: ToDoItem.objectID, title: ToDoItem.title ?? "No Title", info: ToDoItem.info ?? "No Info", createdDate: ToDoItem.createdDate ?? Date(), modifiedDate: ToDoItem.modifiedDate ?? Date())
            
        }
    }
    func updateTodo(tdvm: ToDoViewModel){
        //get the todo
        let existingToDo = CoreDataManager.shared.getToDoByID(tid: tdvm.id)
        print("todo exists\n")
        if let existingToDo = existingToDo{
            print("title before: \(existingToDo.title ?? "No title")")
            existingToDo.title = tdvm.title
            print("title after: \(existingToDo.title ?? "No title")")
            existingToDo.info = tdvm.info
            existingToDo.modifiedDate = tdvm.modifiedDate
            CoreDataManager.shared.updateToDo(t: existingToDo)
        }
        //set the values in the view model to the actual todo
        //and then save
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
