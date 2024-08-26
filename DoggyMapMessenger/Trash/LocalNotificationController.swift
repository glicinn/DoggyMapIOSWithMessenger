////
////  LocalNotificationController.swift
////  DoggyMap
////
////  Created by Дмитрiй Дѣренъ on 25.04.2024.
////
//
//import SwiftUI
//import UserNotifications
//import CoreLocation
//
//class NotificationManager {
//    static let instance = NotificationManager() // Singleton
//    
//    func requestAuthorization(){
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        
//        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
//            if let error = error{
//                print("ERROR: \(error)")
//            } else {
//                print("SUCCESS")
//            }
//        }
//    }
//    
//    func scheduleNotification() {
//        let identifier = "my-notification"
//        let title = "Time to work out!"
//        let body = "Don't be a lazy butt!"
//        let subtitle = "Theese subtitle are Crazy!"
//        let hour = 19
//        let minute = 45
//        let isDaily = true
//        
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
////        content.subtitle = subtitle
//        content.sound = .default
//        content.badge = 1 // Значок
//        
////        Type of triggers:
////        - Time -----------------------------------------
//        
//        // Триггер на отправку уведомления через 5 секунд после создания запроса
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
//        
////        - Location -----------------------------------------
//        
////        // Триггер на отправку уведомления при входе в определенную зону (в данном случае Нью-Йорк)
////        let coordinates = CLLocationCoordinate2D(
////            latitude: 40.722682,
////            longitude: -74.000032)
////        let region = CLCircularRegion(
////            center: coordinates,
////            radius: 10000,
////            identifier: UUID().uuidString)
////        region.notifyOnEntry = true
////        region.notifyOnExit = false
////        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
//        
////        - Calendar -----------------------------------------
//        
////        // Триггер на отправку уведомления каждый день в hour:minute
////        let calendar = Calendar.current
////        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
////        dateComponents.hour = hour
////        dateComponents.minute = minute
////        //dateComponents.weekday = 6 // По субботам
////        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
//        
//        
//        
//        let request = UNNotificationRequest(
//            identifier: identifier,
//            content: content,
//            trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request)
//    }
//    
//    func cancelNotification() {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//    }
//}
//
//struct LocalNotificationController: View {
//    
//    let center = UNUserNotificationCenter.current()
//    
//    var body: some View {
//        VStack(spacing: 40){
//            Button("Request Permission"){
//                NotificationManager.instance.requestAuthorization()
//            }
//            Button("Schedule Notification"){
//                NotificationManager.instance.scheduleNotification()
//            }
//            Button("Cancel Notification"){
//                NotificationManager.instance.cancelNotification()
//            }
//        }
//        .onAppear{
//            // Обнуление уведомлений при открытии
//            center.setBadgeCount(0)
//        }
//    }
//}
//
//#Preview {
//    LocalNotificationController()
//}

import Foundation

class Pet: Identifiable, ObservableObject {
    var id = UUID()
    var name: String
    var gender: String
    var breed: String
    
    init(name: String, gender: String, breed: String) {
        self.name = name
        self.gender = gender
        self.breed = breed
    }
}

class PetViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    
    func addPet(name: String, gender: String, breed: String) {
        let newPet = Pet(name: name, gender: gender, breed: breed)
        pets.append(newPet)
    }
}


import SwiftUI

struct PetsView: View {
    @StateObject var viewModel = PetViewModel()
    @State private var isAddPetPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.pets.isEmpty {
                    Text("You haven't pets")
                        .font(.headline)
                        .padding()
                } else {
                    List(viewModel.pets) { pet in
                        VStack(alignment: .leading) {
                            Text(pet.name)
                                .font(.headline)
                            Text("Gender: \(pet.gender)")
                            Text("Breed: \(pet.breed)")
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isAddPetPresented = true
                }) {
                    Text("Add Pet")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .sheet(isPresented: $isAddPetPresented) {
                    AddPetView(viewModel: viewModel)
                }
            }
            .navigationTitle("Pets")
        }
    }
}


import SwiftUI

struct AddPetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PetViewModel
    @State private var name: String = ""
    @State private var gender: String = "Male"
    @State private var breed: String = "Australian Terrier"
    
    let genders = ["Male", "Female"]
    let breeds = ["Australian Terrier", "Beagle", "Boseron"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pet Info")) {
                    TextField("Name", text: $name)
                    
                    Picker("Gender", selection: $gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    
                    Picker("Breed", selection: $breed) {
                        ForEach(breeds, id: \.self) { breed in
                            Text(breed)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        viewModel.addPet(name: name, gender: gender, breed: breed)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Add Pet")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
