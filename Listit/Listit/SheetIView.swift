//
//  SheetIView.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 17/06/1444 AH.
//

import SwiftUI

struct SheetIView: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    @State private var showsheet: Bool = false
    @State private var showingDetail: Bool = false
    
    @State var addtask = ""
    @State var addnotes = ""
    @State private var days = Date()
    @State private var alarm = Date()
    @State var textfieldText: String = ""
    
    @StateObject var vm = CoreDataViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        NavigationView {
            NavigationView {
                
                VStack {
                    
                    VStack{
                        VStack{
                            Text("Task")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.trailing, 250)
                            
                            ZStack{
                                
                                TextField("Add Task", text: $addtask)
                                    .padding(.trailing, 200.0)
                                    .foregroundColor(Color("Blue"))
                                    .frame(width: 320, height: 50)
                                
                                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                
                                    .padding(.leading)
                            }
                            .keyboardType(.alphabet)
                            
                        }
                        VStack{
                            Text("Description")
                              
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.trailing, 200)
                            
                            ZStack{
                                
                                TextField("Add Description", text: $addnotes)
                                    .accessibilityLabel("Add Description for your task here")
                                    .padding(.trailing, 200.0)
                                    .foregroundColor(Color("Blue"))
                                    .frame(width: 310, height: 50)
                                    .keyboardType(.alphabet)
                                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .padding(.leading)
                            }
                            
                        }
                        
                        
                        VStack(spacing: 5){
                            HStack{
                                Text("Time")
                                    .accessibilityLabel("Add time for your task")
                                    .font(.title3)
                                
                                    .foregroundColor(.black)
                                    .padding(.leading, 45.0)
                                Image(systemName: "alarm.fill")
                                    .foregroundColor(.black)
                                
                                DatePicker("", selection: $days)
                                
                                    .padding()
                                    .foregroundColor(Color("Blue"))
                                    .accentColor(Color("Blue"))
                              
                            }
                            
                        }
                        HStack{
                            
                            Text("Alarm")
                                .accessibilityLabel("Add time alarm for your task here to remind you")

                                .font(.title3)
                            
                                .foregroundColor(.black)
                                .padding(.leading, 45.0)
                            Image(systemName: "bell.badge.fill")
                                .foregroundColor(.black)
                            DatePicker("", selection: $alarm, displayedComponents: [.hourAndMinute])
                                .padding()
                                .foregroundColor(Color("Blue"))
                                .accentColor(Color("Blue"))
                            
                            
                        }.padding(.bottom)
                        
                        
                        
                    }
                    // MARK: -
                    
                    Button("Save Task") {
                        coreDataViewModel.addList(title: addtask, descriotion: addnotes, date: days )
                         dismiss()
                    }
                    .accessibilityLabel("Enter to save your task")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color("Blue"))
                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    
                }
            }
        }
        
        
    }}

struct SheetIView_Previews: PreviewProvider {
    static var previews: some View {
        SheetIView()
            .environmentObject(CoreDataViewModel())
    }
}
