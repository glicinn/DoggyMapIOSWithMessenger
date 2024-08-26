//
//  Route.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 12.05.2024.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
