//
//  LoginViewModel.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 10.05.2024.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var surname = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, name: name, surname: surname)
    }
    
}
