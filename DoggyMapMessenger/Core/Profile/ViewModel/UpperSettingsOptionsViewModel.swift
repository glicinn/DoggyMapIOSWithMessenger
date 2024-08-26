//
//  SettingsOptionsViewModel.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 08.05.2024.
//

import Foundation
import SwiftUI

enum UpperSettingsOptionsViewModel: Int, CaseIterable, Identifiable{
    case calendar

    
    var title: String{
        switch self {
        case .calendar: return "My Calendar"
        }
    }
    
    var imageName: String{
        switch self {
        case .calendar: return "calendar"
        }
    }
    
    var imageBackgroundColor: Color{
        switch self {
        case .calendar: return .purple
        }
    }
    
    var id: Int { return self.rawValue }
}
