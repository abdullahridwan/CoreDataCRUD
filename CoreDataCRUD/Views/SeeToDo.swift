//
//  SeeToDo.swift
//  CoreDataCRUD
//
//  Created by Abdullah Ridwan on 1/4/22.
//

import SwiftUI

struct SeeToDo: View {
    @Binding var newToDo: NewToDo
    
    var body: some View {
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
            NavigationView{
                VStack {
                    Form{
                        Section{
                            TextField("\(newToDo.title)", text: $newToDo.title)
                                .font(.title)
                        }
                        Section{
                            DatePicker("Modified Date: ", selection: $newToDo.modifiedDate)
                        }
                        TextField("\(newToDo.info)", text: $newToDo.info)
                            .frame(width: .infinity, height:100)
                            
                        
                    }
                }
            }
        }
        
    }
}

//struct SeeToDo_Previews: PreviewProvider {
//    static var previews: some View {
//        SeeToDo(todoVM: .constant(ToDoViewModel(todo: <#T##ToDoItem#>)))
//    }
//}
