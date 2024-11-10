//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Hatice Kar on 9.11.2024.
//

import Foundation


class ListViewModel : ObservableObject {
 
    @Published var items : [ItemModel] = []
    {
        didSet{
            saveItems()
        }
    }
    let itemsKey : String = "items_list"
    
    init () {
        getItems()
    }
    
    func getItems(){
      /*  let newItems = [
            ItemModel(title: "This is first title!", isCompleted: false),
            ItemModel(title: "This is the second!", isCompleted: true),
            ItemModel(title: "Third!", isCompleted: false)
        ]
        items.append(contentsOf: newItems)*/
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey), 
            let savedtems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedtems
        
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
        saveItems()
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
        saveItems()
    }
    
    func addItem(title : String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    func updateItem(item: ItemModel){
        /*if let index = items.firstIndex {
            (existingItem) -> Bool in
            return existingItem.id == item.id
        }{
            // run the code
        }*/
        
        if let index = items.firstIndex(where: {$0.id == item.id}){
           // items[index] = ItemModel(title: item.title, isCompleted: !item.isCompleted)
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}
