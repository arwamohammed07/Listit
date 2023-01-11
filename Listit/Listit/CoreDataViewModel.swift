//
//  CoreDataViewModel.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 16/06/1444 AH.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities: [List] = []
    
    init() {
        container = NSPersistentContainer (name: "ListContainer")
        container .loadPersistentStores { (description, error) in
            if let error = error {
                print ("ERROR LOADING CORE DATA. \(error)")
            }
            
        }
        fetchList()
    }
    func fetchList(){
        let request = NSFetchRequest<List>(entityName: "List")
        
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
    func addList(title: String, descriotion: String, date: Date ){
        let newList = List(context: container.viewContext)
        newList.taskTitle = title
        newList.taskDescription = descriotion
        newList.taskDate = date
        print(title)
        print(descriotion)
        print(date)
        saveData()
    }
    func updateList(entity: List) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    func deleteList(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[ index]
        container.viewContext.delete(entity)
        saveData ( )
    }
    func saveData() {
        do {
            try container.viewContext.save()
            fetchList()
        }catch let error{
            print("Error fetching. \(error)")
        }
    }

}
