//
//  SettingsOptionsViewModel.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 08.05.2024.
//

import Foundation
import SwiftUI

enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable{
    case darkMode
    case activeStatus
    case privacy
    case notifications
    case functions
    
    var title: String{
        switch self {
        case .darkMode: return "Dark Mode"
        case .activeStatus: return "Active Status"
        case .privacy: return "Privacy and Safety"
        case .notifications: return "Notifications"
        case .functions: return "Functions"
        }
    }
    
    var imageName: String{
        switch self {
        case .darkMode: return "moon.fill"
        case .activeStatus: return "message.badge.filled.fill"
        case .privacy: return "lock.fill"
        case .notifications: return "bell.badge.fill"
        case .functions: return "lightbulb.fill"
        }
    }
    
    var imageBackgroundColor: Color{
        switch self {
        case .darkMode: return .black
        case .activeStatus: return .green
        case .privacy: return .blue
        case .notifications: return .pink
        case .functions: return .yellow
        }
    }
    
    var id: Int { return self.rawValue }
}
