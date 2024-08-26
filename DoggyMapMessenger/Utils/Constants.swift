//
//  Constants.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 12.05.2024.
//

import Foundation
import Firebase

struct FirestoreConstants {
    
    static let UserCollection =  Firestore.firestore().collection("users")
    static let MessagesCollection =  Firestore.firestore().collection("messages")
    
}
