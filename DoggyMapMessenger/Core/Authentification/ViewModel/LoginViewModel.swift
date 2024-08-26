//
//  LoginViewModel.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 10.05.2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
}
