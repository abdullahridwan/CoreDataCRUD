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
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
            NavigationView{
                VStack {
                    Form{
                        Section{
                            TextField("Title...", text: $newToDo.title)
                                .font(.title)
                        }
                        Section{
                            DatePicker("Modified Date: ", selection: $newToDo.modifiedDate)
                        }
                        TextField("Type something...", text: $newToDo.info)
                            .frame(width: .infinity, height:100)
                            
                        
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
                .background(Color.red)
            }
            .background(Color.red)
        }
        
        
        
        
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(newToDo: .constant(NewToDo(title: "", info: "", createdDate: Date(), modifiedDate: Date())), showSheet: .constant(true), pressedSave: .constant(false))
    }
}
