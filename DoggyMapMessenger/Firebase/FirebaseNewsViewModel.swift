//
//  FirebaseTestViewModel.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 25.04.2023.
//

import Foundation
import Firebase

class FirebaseNewsViewModel: ObservableObject {
    

    @Published var list = [News]()

    
    
    
    func updateData(newsToUpdate: News, newappDescription: String, newappLogo: String, newappName: String, newartwork: String, newbannerTitle: String, newplatformTitle: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("news").document(newsToUpdate.id).setData (["appDescription":"\(newappDescription)"], merge: true) { error in
            db.collection("news").document(newsToUpdate.id).setData (["appLogo":"\(newappLogo)"], merge: true) { error in
                db.collection("news").document(newsToUpdate.id).setData (["appName":"\(newappName)"], merge: true) { error in
                    db.collection("news").document(newsToUpdate.id).setData (["artwork":"\(newartwork)"], merge: true) { error in
                        db.collection("news").document(newsToUpdate.id).setData (["bannerTitle":"\(newbannerTitle)"], merge: true) { error in
                            db.collection("news").document(newsToUpdate.id).setData (["platformTitle":"\(newplatformTitle)"], merge: true) { error in
                                if error == nil {
                                    // Get the new data
                                    self.getData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    func deleteData (newsToDelete: News) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("news").document (newsToDelete.id).delete { error in
            // Check for errors
            if error == nil {
                // No errors
                // Update the UI from the main thread
                DispatchQueue.main.async{
                    // Remove the todo that was just deleted
                    self.list.removeAll { news in
                        // Check for the todo to remove
                        return news.id == newsToDelete.id
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    func addData(appDescription: String, appLogo: String, appName: String, artwork: String, bannerTitle: String, platformTitle: String){
        //Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to the collection
        
        
        db.collection("news").document(appName).setData([
            "appDescription": appDescription,
            "appLogo": appLogo,
            "appName": appName,
            "artwork": artwork,
            "bannerTitle": bannerTitle,
            "platformTitle": platformTitle
        ]){ error in
            if error == nil {
                // No errors
                
                // Call getdata to retrieve latest data
                self.getData()
            }
            else {
                // Handle the error
            }
        }
    }
    
    
    
    
    
    
    
    
    func getData(){
        // Gete a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("news").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot{
                    
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create todos
                        self.list = snapshot.documents.map{ d in
                            
                            
                            
                            //Create a firebase item for each document returned
                            return News(id: d.documentID,
                                        appDescription: d["appDescription"] as? String ?? "",
                                        appLogo: d["appLogo"] as? String ?? "",
                                        appName: d["appName"] as? String ?? "",
                                        artwork: d["artwork"] as? String ?? "",
                                        bannerTitle: d["bannerTitle"] as? String ?? "",
                                        platformTitle: d["platformTitle"] as? String ?? "")
                        }
                    }
                    
                }
            }
            else {
                // Handle the error
            }
            
            
        }
    }
    
}

