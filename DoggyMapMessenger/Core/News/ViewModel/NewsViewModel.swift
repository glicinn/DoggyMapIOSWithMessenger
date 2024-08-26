//
//  NewsViewModel.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 21.05.2023.
//

import Foundation
import Firebase

class NewsViewModel: ObservableObject {
    
    @Published var list = [News]()
    
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
