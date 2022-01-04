//
//  ToDoApp.swift
//  CoreDataCRUD
//
//  Created by Abdullah Ridwan on 1/2/22.
//

import SwiftUI

struct ToDoApp: View {
    @State private var newToDoItem = NewToDo(title: "", info: "", createdDate: Date(), modifiedDate: Date())
    @State private var showSheet = false
    @State private var pressedSave = false
    @StateObject var todoList = ToDoAppViewModel()
    @State var level = Priority.all
    @State private var editMode = EditMode.inactive
    
    
    //crud applications
    func save(){}
    func read(){}
    func update(){}
    private func deleteTodo (at offsets: IndexSet) {
        offsets.forEach { index in
            let task = todoList.allTasks[index]
            todoList.deleteTodo(todo: task)
        }
        todoList.getAllToDos()
    }
    
    private func moveTodo(source: IndexSet, destination: Int) {
        todoList.allTasks.move(fromOffsets: source, toOffset: destination)
        todoList.save()
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
              
                VStack{
                    LevelPicker(level: level)
                        .padding()
                    NavigationView{
                        List{
                            ForEach(todoList.allTasks, id: \.id){ aTask in
                                    HStack{
                                        Image(systemName: "pencil.circle")
                                        VStack(alignment: .leading){
                                            Text(aTask.title)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                            Text(aTask.info)
                                                .font(.subheadline)
                                        }
                                    }
                            }
                            .onDelete(perform: deleteTodo)
                            //.onMove(perform: moveTodo)
                        }
                        .onAppear(perform: {
                            todoList.getAllToDos()
                            UITableView.appearance().backgroundColor =  UIColor(named: "Background")
                        })
                        .onChange(of: pressedSave, perform: { value in
                            print("value is \(value)")
                            if(value == true){
                                if(newToDoItem.title != ""){
                                    todoList.saveTodo(td: newToDoItem)
                                    newToDoItem = NewToDo(title: "", info: "", createdDate: Date(), modifiedDate: Date())
                                    todoList.getAllToDos()
                                }
                                pressedSave = false
                            }
                        })
                        .navigationBarItems(leading: EditButton(), trailing: addButton)
                        .environment(\.editMode, $editMode)
                        .sheet(isPresented: $showSheet, content: {
                            AddToDoView(newToDo: $newToDoItem, showSheet: $showSheet, pressedSave: $pressedSave)
                        })
                    }
                }
            }
            .navigationBarTitle("To Dos")
        }
    }
    
    
    //given the priority level, show a different list
    func getTask(level: Priority) -> [ToDoViewModel] {
        switch level {
        case .all:
            return todoList.allTasks
        case .low:
            return todoList.lowTasks
        case .medium:
            return todoList.mediumTasks
        case .high:
            return todoList.highTasks
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: {
                showSheet.toggle()
            }) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
}

struct ToDoApp_Previews: PreviewProvider {
    static var previews: some View {
        ToDoApp()
    }
}

struct LevelPicker: View {
    @State var level: Priority
    var body: some View {
        Picker(selection: $level, label: Text("")) {
            ForEach(Array(Priority.allCases), id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .labelsHidden()
    }
}
