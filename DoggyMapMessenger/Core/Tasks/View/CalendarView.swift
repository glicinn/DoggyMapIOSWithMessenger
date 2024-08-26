//
//  CalendarView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 01.04.2024.
//

import SwiftUI

struct CalendarView: View {
    /// - View Properties
    @State private var currentDay: Date = .init()
    @State private var tasks: [Note] = sampleTasks
    @State private var addNewTask: Bool = false
    
    @StateObject var viewModel = ProfileViewModel()
    let user: User
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            TimelineView()
                .padding(15)
        }
        .safeAreaInset(edge: .top, spacing: 0){
            HeaderView()
        }
        .fullScreenCover(isPresented: $addNewTask){
//            AddTaskView{ task in
//                /// - Simply Add it to tasks
//                tasks.append(task)
//            }
            
            AddTaskView(onAdd: { task in
                /// - Simply Add it to tasks
                tasks.append(task)
            }, user: user)
        }
    }
    
    /// - Timeline View
    @ViewBuilder
    func TimelineView()-> some View{
        ScrollViewReader{ proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack{
                ForEach(hours, id: \.self){hour in
                    TimelineViewRow(hour)
                        .id(hour)
                }
            }
            .onAppear{
                proxy.scrollTo(midHour)
            }
        }
    }
    
    /// - Timeline View Row
    @ViewBuilder
    func TimelineViewRow(_ date: Date)-> some View{
        HStack(alignment: .top){
            Text(date.toString("h a"))
                .font(.custom("Avenir", size: 14))
                .frame(width: 45, alignment: .leading)
            
            /// - Filtering Tasks
            let calendar = Calendar.current
            let filteredTasks = tasks.filter{
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
                   hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay){
                    return true
                }
                return false
            }
            if filteredTasks.isEmpty{
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            }else{
                /// - Task View
                VStack(spacing: 10){
                    ForEach(filteredTasks){ task in
                        TaskRow(task)
                    }
                }
            }
            
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
    
    
    
    /// - Task Row
    @ViewBuilder
    func TaskRow(_ task: Note)-> some View{
        VStack(alignment: .leading, spacing: 8){
            Text(task.taskName.uppercased())
                .font(.custom("Avenir", size: 16))
                .foregroundColor(task.taskCategory.color)
            
            if task.taskDescription != ""{
                Text(task.taskDescription)
                    .font(.custom("Avenir", size: 14).weight(.light))
                    .foregroundColor(task.taskCategory.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(task.taskCategory.color)
                    .frame(width: 4)
                
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.25))
            }
        }
    }
    
    /// - Header View
    @ViewBuilder
    func HeaderView()-> some View{
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 6){
                    Text("today-string".localized)
                        .font(Font.custom("Avenir", size: 30))
                    Text("welcome-string".localized + " \(user.name)")
                        .font(Font.custom("Avenir", size: 14))
                }
                .hAlign(.leading)
                
                Button {
                    addNewTask.toggle()
                } label: {
                    HStack(spacing: 10){
                        Image(systemName: "plus")
                        Text("add-task-string".localized)
                            .font(Font.custom("Avenir", size: 15))
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background{
                        Capsule()
                            .fill(Color("Blue").gradient)
                    }
                    .foregroundColor(.white)
                }
            }
            
            /// - Today Date in String
            Text(Date().toString("MMM YYYY"))
                .font(Font.custom("Avenir", size: 16))
                .hAlign(.leading)
                .padding(.top, 15)
            
            /// - Current Week Row
            WeekRow()
        }
        .padding(15)
        .background{
            VStack(spacing: 0){
                Color.white
                
                /// - Gradient Opacity Background
                Rectangle()
                    .fill(.linearGradient(
                        colors: [.white, .clear],
                        startPoint: .top,
                        endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
        }
    }
    
    /// - Week Row
    @ViewBuilder
    func WeekRow()-> some View{
        HStack(spacing: 0){
            ForEach(Calendar.current.currentWeek){weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6){
                    Text(weekDay.string.prefix(3))
                        .font(Font.custom("Avenir", size: 12))
                    Text(weekDay.date.toString("dd"))
                        .font(Font.custom("Avenir", size: 16))

                }
                .foregroundColor(status ? Color("Blue") : .gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)){
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }

}
//
//#Preview {
//    CalendarView()
//}

// MARK: View extensions
extension View{
    func hAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

// MARK: Date Extension
extension Date{
    func toString(_ format: String)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}

// MARK: Caalendar Extension

extension Calendar{
    /// - Return 24 Hours in a Day
    var hours: [Date]{
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24{
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay){
                hours.append(date)
            }
        }
        return hours
    }
    
    /// - Return Current Week in Array Format
    var currentWeek: [WeekDay]{
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start
            else {return[]}
        var week: [WeekDay] = []
        for index in 0..<7{
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay){
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
        }
        return week
    }
    
    /// - Used to Store Data of Each Week Day
    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
