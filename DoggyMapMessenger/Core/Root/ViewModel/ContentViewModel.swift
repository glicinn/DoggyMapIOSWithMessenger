//
//  ContentViewModel.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 12.05.2024.
//

import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellabes = Set<AnyCancellable>()
    
    init(){
        setupSubscribers()
    }
    
    
    // Отслеживание обновлений при помощи Combine
    private func setupSubscribers(){
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellabes)
    }
}
