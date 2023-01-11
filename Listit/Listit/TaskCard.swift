//
//  TaskCard.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 15/06/1444 AH.
//

import SwiftUI

struct TaskCard: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel

    @ObservedObject var test = TaskViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var vm = CoreDataViewModel()

    @State private var checked = true
   @State private var enableDelete = true
    
  
    var body: some View {

        Group{

            HStack{
                CheckBoxView(checked: $checked)

                VStack{
                    HStack{
                        Rectangle()
                            .frame(width: 24
                                   , height: 70)
                            .foregroundColor(Color("Blue"))
                            .clipShape(Rectangle())

                            .padding(.trailing, 3.0)

                        VStack(alignment: .leading){

                            Text(test.storedTasks[1].taskDate.formatted(date: .omitted, time: .shortened))
                            
                                .font(.caption)
                                .foregroundColor(.gray)

                            Text(test.storedTasks[1].taskTitle)
                                .font(.title3.bold())
                                .foregroundColor(.black)


                            Text(test.storedTasks[1].taskDescription)
                                .font(.callout)
                                .foregroundColor(.black)

                        }

                        Spacer()

                    }

                }
                .frame(width: 295, height: 70)
                .padding(.trailing)
                .background(Color(.white))
                .foregroundColor(.white)
                .clipShape(Rectangle())
                .shadow(radius: 3)

            }

        }
        //.onDelete(perform: deleteList(indexSet: IndexSet))

    }
}
    


struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard()
            .environmentObject(CoreDataViewModel())

    }
}

