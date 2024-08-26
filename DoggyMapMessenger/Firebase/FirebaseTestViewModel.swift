////
////  FirebaseTestViewModel.swift
////  DoggyMap
////
////  Created by Дмитрiй Дѣренъ on 25.04.2023.
////
//
//import Foundation
//import Firebase
//
//class FirebaseTestViewModel: ObservableObject {
//    
//
//    @Published var list = [FirebaseTest]()
//
//    
//    
//    
//    
////    func viewName(login: String){
////        // Gete a reference to the database
////        let db = Firestore.firestore()
////        
////        // Read the documents at a specific path
////        let docRef = db.collection("users").document("\(login)")
////        
////        docRef.getDocument { (document, error) in
////               guard error == nil else {
////                   print("error", error ?? "")
////                   return
////               }
////
////               if let document = document, document.exists {
////                   let data = document.data()
////                   if let data = data {
////                       print("data", data)
////                       self.user = data["name"] as? String ?? ""
////                       self.user = data["surname"] as? String ?? ""
////                       print ("\(data["name"] as? String ?? "") \(data["surname"] as? String ?? "")")
////                   }
////               }
////
////           }
////    }
//    
//    
//    
//    
//    func updateData(userToUpdate: FirebaseTest, newName: String, newSurname: String) {
//        // Get a reference to the database
//        let db = Firestore.firestore()
//        // Set the data to update
//        db.collection("users").document(userToUpdate.id).setData (["name":"\(newName)"], merge: true) { error in
//            db.collection("users").document(userToUpdate.id).setData (["surname":"\(newSurname)"], merge: true) { error in
//                if error == nil {
//                    // Get the new data
//                    self.getData()
//                }
//            }
//        }
//    }
//    
//    
//    
//    
//    func deleteData (usersToDelete: FirebaseTest) {
//        // Get a reference to the database
//        let db = Firestore.firestore()
//        // Specify the document to delete
//        db.collection("users").document (usersToDelete.id).delete { error in
//            // Check for errors
//            if error == nil {
//                // No errors
//                // Update the UI from the main thread
//                DispatchQueue.main.async{
//                    // Remove the todo that was just deleted
//                    self.list.removeAll { users in
//                        // Check for the todo to remove
//                        return users.id == usersToDelete.id
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    
//    func addData(name: String, surname: String, login: String){
//        let db = Firestore.firestore()
//        
//        
//        db.collection("users").document(login).setData([
//            "name": name,
//            "surname": surname
//        ]){ error in
//            if error == nil {
//                self.getData()
//            }
//            else {
//            }
//        }
//    
//    
//    
//    
//    
////    func addData(name: String, surname: String, login: String){
////        //Get a reference to the database
////        let db = Firestore.firestore()
////        // Add a document to the collection
////
////
////        db.collection("users").document(login).setData([
////            "name": name,
////            "surname": surname
////        ]){ error in
////            if error == nil {
////                // No errors
////
////                // Call getdata to retrieve latest data
////                self.getData()
////            }
////            else {
////                // Handle the error
////            }
////        }
//        
////        db.collection("users").addDocument(data: ["name":name, "surname":surname]){ error in
////            // Check for errors
////            if error == nil {
////                // No errors
////
////                // Call getdata to retrieve latest data
////
////                self.getData()
////            }
////            else {
////                // Handle the error
////            }
////        }
//        
//        
//        
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    func getData(){
//        // Gete a reference to the database
//        let db = Firestore.firestore()
//        
//        // Read the documents at a specific path
//        db.collection("users").getDocuments { snapshot, error in
//            
//            // Check for errors
//            if error == nil {
//                // No errors
//                if let snapshot = snapshot{
//                    
//                    //Update the list property in the main thread
//                    DispatchQueue.main.async {
//                        // Get all the documents and create todos
//                        self.list = snapshot.documents.map{ d in
//                            
//                            //Create a firebase item for each document returned
//                            return FirebaseTest(id: d.documentID,
//                                                name: d["name"] as? String ?? "",
//                                                surname: d["surname"] as? String ?? "")
//                        }
//                    }
//                    
//                }
//            }
//            else {
//                // Handle the error
//            }
//            
//            
//        }
//    }
//    
//    
//    
//    
//    
//    
//}
//
