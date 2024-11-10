//
//  ListView.swift
//  ToDoList
//
//  Created by Hatice Kar on 9.11.2024.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel : ListViewModel
    
    /*@State var items : [ItemModel] = [
        ItemModel(title: "This is first title!", isCompleted: false),
        ItemModel(title: "This is the second!", isCompleted: true),
        ItemModel(title: "Third!", isCompleted: false)
    ]*/
    
    var body : some View {
        
        ZStack{
            
            if listViewModel.items.isEmpty{
                NoItemsView()
                    //.transaction //(AnyTransition.opacity.animation(.easeIn))
            }else{
                List {
                    ForEach(listViewModel.items) {
                        item in ListRowView(item: item, title: "")
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                    
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
            
        }
      
        .navigationTitle("ToDo List 📋")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView()))
                   
    }
   
}
#Preview {
    NavigationView{
        ListView()
    }
    .environmentObject(ListViewModel())
}
