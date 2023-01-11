//
//  TaskViewModel.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 14/06/1444 AH.
//

import SwiftUI
import Foundation

class TaskViewModel: ObservableObject{
 //   @Published var storedTasks = [Task] ()
    //نفس الاري تقريبا المهام ووصفها
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Business Event", taskDescription: "Riyadh Front", taskDate:
                .init (timeIntervalSince1970: 1673467564)),
        Task(taskTitle: "Meeting Classmatts", taskDescription: "With Sara and Asma", taskDate:
                .init (timeIntervalSince1970: 1673453153)),
        Task(taskTitle: "Go to Gym", taskDescription: "Shoulders exercise", taskDate: .init (timeIntervalSince1970: 1673453153)),
        Task(taskTitle: "Read a book", taskDescription: "Agatha Christie", taskDate:
                .init (timeIntervalSince1970: 1673394614)),
        
        
    ]
    //week viewdays
    @Published var currentWeek: [Date] = []
    // Current Day
    @Published var currentDay: Date = Date()
    // feltring today task
    @Published var filteredTask: [Task]?
    
    init (){
        fetchCurrentWeek()
        filteredTodayTask()
    }
    //        filterTodayTasks()
    func filteredTodayTask(){
        DispatchQueue.global(qos: .userInteractive).async {
            let calender = Calendar.current
            let filtered = self.storedTasks.filter{
                return calender.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTask = filtered
                }
            }
        }
    }
    func fetchCurrentWeek() {
        let today = Date ()
        let calendar = Calendar.current
        //عدلته هنا عشان يطبع الاسبوع هذا منweek الى month
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
            guard let firstWeekDay = week?.start else{
            return
        }
        (1...15).forEach { day in
            if let weekday = calendar.date (byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    //MARK: Extracting Date
    func extractDate(date: Date, format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    // Mark: Checking if current Date is Today
    func isToday(date: Date)->Bool{
        
        let calender = Calendar.current
        
        return calender.isDate(currentDay, inSameDayAs: date)
        
        // Mark: Checking if current Hour is task Hour
        func isCurrentHour (date: Date)->Bool{
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let currentHour = calendar.component(.hour, from: Date())

            return hour == currentHour
        }
    }
}
