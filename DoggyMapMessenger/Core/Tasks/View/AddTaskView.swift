//
//  AddtaskView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 01.04.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class FirestoreManager {
    let db = Firestore.firestore()

    func addNote(name: String, category: String, date: TimeInterval, description: String, userLogin: String) {
            let noteData: [String: Any] = [
                "category": category,
                "date": date,
                "description": description,
                "user_login": userLogin
            ]

            db.collection("notes").document(name).setData(noteData) { error in
                if let error = error {
                    print("Error adding note: \(error)")
                } else {
                    print("Note added successfully!")
                }
            }
        }
}



struct AddTaskView: View {
    /// - CallBack
    var onAdd: (Note)->()
    /// - View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskCategory: Category = .general
    /// - Category Animation Properties
    @State private var animateColor: Color = Category.general.color
    @State private var animate: Bool = false
    
    @StateObject var viewModel = ProfileViewModel()
    let user: User
    
    @AppStorage("uLogin") var userLogin: String = ""
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 10){
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }
                
                Text("create-new-task-string".localized)
                    .font(.custom("Avenir", size: 28))
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                
                TitleView("task-name-string".localized)
                TextField("task-name-description-string".localized, text: $taskName)
                    .font(.custom("Avenir", size: 16))
                    .tint(.white)
                    .padding(.top, 2)
                    
                
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                
                TitleView("task-date-string".localized)
                    .padding(.top, 15)
                
                HStack(alignment: .bottom, spacing: 12){
                    HStack(spacing: 12){
                        Text(taskDate.toString("EEEE dd, MMMM"))
                            .font(.custom("Avenir", size: 16))
                        
                        /// - Custom Dtae Picker
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate, displayedComponents: 
                                            [.date])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                    
                    HStack(spacing: 12){
                        Text(taskDate.toString("hh:mm a"))
                            .font(.custom("Avenir", size: 16))
                        
                        /// - Custom Dtae Picker
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate, displayedComponents: 
                                            [.hourAndMinute])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                }
                .padding(.bottom, 15)
                
            }
            .environment(\.colorScheme, .dark)
            .hAlign(.leading)
            .padding(15)
            .background{
                ZStack{
                    taskCategory.color
                    
                    GeometryReader{
                        let size = $0.size
                        Rectangle()
                            .fill(animateColor)
                            .mask{
                                Circle()
                            }
                            .frame(
                                width: animate ? size.width * 2 : 0,
                                height: animate ? size.height * 2 : 0
                            )
                            .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
                    }
                    .clipped()
                }
                .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                TitleView("task-description-string".localized, .gray)
                
                TextField("task-description-description-string".localized, text: $taskDescription)
                    .font(.custom("Avenir", size: 16))
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(.black.opacity(0.2))
                    .frame(height: 1)
                
                TitleView("task-category-string".localized, .gray)
                    .padding(.top, 15)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 15){
                    ForEach(Category.allCases, id: \.rawValue){category in
                        Text(category.rawValue.uppercased())
                            .font(.custom("Avenir", size: 12))
                            .hAlign(.center)
                            .padding(.vertical, 5)
                            .background{
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(category.color.opacity(0.25))
                            }
                            .foregroundColor(category.color)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                guard !animate else{return}
                                animateColor = category.color
//                                (response: 0.7, dampingRatio: 1, blendDuration: 1)
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)){
                                    animate = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                                    animate = false
                                    taskCategory = category
                                }
                            }
                    }
                }
                .padding(.top, 5)
                
                Button{
                    /// - Creating Task And Pass it to the Callback
                    let task = Note(dateAdded: taskDate, taskName: taskName, taskDescription: taskDescription, taskCategory: taskCategory)
                    onAdd(task)
                    dismiss()
                    
                    

                       let name = taskName
                       let category = taskCategory.rawValue.uppercased()
                       let date = taskDate.timeIntervalSince1970 // Преобразуем объект Date в TimeInterval
                       let description = taskDescription
                    let userLogin = user.email
                    print(name,category,date,description,userLogin)
                       // Создаем экземпляр FirestoreManager и добавляем заметку
                       let firestoreManager = FirestoreManager()
                       firestoreManager.addNote(name: name, category: category, date: date, description: description, userLogin: userLogin)

                
                
                } label: {
                    Text("create-string".localized)
                        .font(.custom("Avenir", size: 16))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .hAlign(.center)
                        .background{
                            Capsule()
                                .fill(animateColor.gradient)
                        }
                }
                .vAlign(.bottom)
                .disabled(taskName == "" || animate)
                .opacity(taskName == "" ? 0.6 : 1)
            }
            .padding(15)
        }
        .vAlign(.top)
    }
    
    @ViewBuilder
    func TitleView(_ value: String,_ color: Color = .white.opacity(0.7))-> some View{
        Text(value.uppercased())
            .font(.custom("Avenir", size: 12))
            .foregroundColor(color)
    }
    
}

//#Preview {
//    AddtaskView()
//}
