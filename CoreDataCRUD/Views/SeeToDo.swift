//
//  SeeToDo.swift
//  CoreDataCRUD
//
//  Created by Abdullah Ridwan on 1/4/22.
//

import SwiftUI

struct SeeToDo: View {
    @Binding var todoVM: ToDoViewModel
    @EnvironmentObject var todoList: ToDoAppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                    .edgesIgnoringSafeArea(.all)
                    VStack {
                        Form{
                            Section{
                                TextField("\(todoVM.title)", text: $todoVM.title)
                                    .font(.title)
                            }
                            Section{
                                DatePicker("Modified Date: ", selection: $todoVM.modifiedDate)
                            }
                            TextField("\(todoVM.info)", text: $todoVM.info)
                        }
                    }
                    .background(Color.red)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading, content: {
                Button(action:{
                    print("New title is \(todoVM.title)")
                    todoList.updateTodo(tdvm: todoVM)
                    presentationMode.wrappedValue.dismiss()
                    
                }, label:{
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.blue)
                    Text("Back")
                        .foregroundColor(Color.blue)
                })
            })
        })
        
    }
}

//struct SeeToDo_Previews: PreviewProvider {
//    static var previews: some View {
//        SeeToDo(todoVM: .constant(ToDoViewModel(todo: ToDoViewModel())))
//    }
//}
