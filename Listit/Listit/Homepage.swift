//
//  Homepage.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 14/06/1444 AH.
//

import SwiftUI

struct Homepage: View {
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    
    @Namespace var animation
    @State private var checked = true
    @StateObject var vm = CoreDataViewModel()
    @State var textfieldText: String = ""
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 10) {
                    Text("Daily Tasks")
                        .bold()
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                    
                }.toolbar {
                    ToolbarItem {
                        Button("Add") {
                            
                            showingDetail = true
                        }
                        .sheet(isPresented: $showingDetail) {
                            
                            SheetIView()
                                .environmentObject(vm)
                        }
                    }
                    
                }
                ScrollView(.vertical, showsIndicators: false) {
                    //نسوي الهيدر هنا مع الاضافه
                    LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                        Section{
                            // MARK: - week View
                            ScrollView(.horizontal,showsIndicators: false){
                                
                                HStack(spacing: 15){ ForEach(taskModel.currentWeek,id: \.self){day in
                                    // DD will return day as 09, 08 , 07 ....etc يطبع الايام مع الصفر باليسار
                                    
                                    VStack(spacing: 10){
                                        Text(taskModel.extractDate(date: day, format: "DD"))
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                        // EEE will return day as MON , TUE , SAT ....etc
                                        Text(taskModel.extractDate(date: day, format: "EE"))
                                            .font(.system(size: 16))
                                        // .fontWeight(.semibold)
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 8 , height: 8)
                                            .opacity(taskModel.isToday(date: day) ? 1:0)
                                    }
                                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                    .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                    // MARK: -  Capsule Shape
                                    .frame(width: 45, height: 100)
                                    .background(
                                        ZStack{
                                            //           Capsule()
                                            //.fill(.white)
                                            if taskModel.isToday(date: day){
                                                Capsule()
                                                    .fill(Color("Blue"))
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                            
                                        }
                                    )
                                    .contentShape(Capsule())
                                    
                                    .onTapGesture {
                                        // MARK: - upditing date
                                        withAnimation{
                                            taskModel.currentDay = day
                                        }
                                    }
                                }
                                }
                                .padding(.horizontal)
                                
                            }
                            TasksView()
                            
                        }
                        HStack {
                            VStack(spacing: 10) {
                                Text("")
                                    .font(.title)
                                
                                
                                    .foregroundColor(.gray)
                                
                            }
                            .navigationBarItems(trailing: Button(action: {
                                
                            }, label: {
                                SheetIView()
                                    .environmentObject(vm)
                            } ) )
                        }
                        .padding(.bottom, 350)
                        
                        
                    }
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    // MARK: - task view
    func TasksView()-> some View{
        LazyVStack(spacing: 18) {
            if let tasks = taskModel.filteredTask{
                if tasks.isEmpty{
                    Text("No Task Found!")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .fontWeight(.light)
                        .offset(y:100)
                }
                else{
                    VStack{
                        
                        
                        ForEach(tasks) { task in
                            
                            TaskCard()
                            
                            
                        }
                        //.onDelete(perform: deleteList)
                        .padding(.vertical, 10)
                        
                    }.frame(width: 300)
                    // .scrollContentBackground(.hidden)
                }
            }
            else{
                // MARK: - prograss view
                ProgressView()
                    .offset(y:100)
            }
        }
        
        
        .padding()
        .padding(.top)
        // MARK: - upditing task
        .onChange(of: taskModel.currentDay) { newValue in taskModel.filteredTodayTask()
        }
        
    }
}


struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
            .environmentObject(CoreDataViewModel())
    }
}
