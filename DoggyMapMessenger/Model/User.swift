//
//  User.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 08.05.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let name: String
    let surname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String{
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(name: "Dmitrii", surname: "Deren", email: "dimaderen1@gmail.com", profileImageUrl: "")
}
