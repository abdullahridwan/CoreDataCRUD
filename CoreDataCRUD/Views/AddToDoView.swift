//
//  AddToDoView.swift
//  CoreDataCRUD
//
//  Created by Abdullah Ridwan on 1/3/22.
//

import SwiftUI

struct AddToDoView: View {
    @StateObject private var todoList = ToDoAppViewModel()
    @Binding var newToDo: NewToDo
    @Binding var showSheet: Bool
    @Binding var pressedSave: Bool
    var body: some View {
        NavigationView{
            Form{
                TextField("Title...", text: $newToDo.title)
                TextField("Type something...", text: $newToDo.info)
                DatePicker("Modified Date: ", selection: $newToDo.modifiedDate)
            }
            .navigationTitle("Add a note")
            .toolbar(content: {
                Button(action: {
                    //save the note if there is no title
                    pressedSave = true
                    showSheet.toggle()
                }, label: {
                    Text("Save")
                        .foregroundColor(Color.blue)
                })
            })
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(newToDo: .constant(NewToDo(title: "", info: "", createdDate: Date(), modifiedDate: Date())), showSheet: .constant(true), pressedSave: .constant(false))
    }
}
