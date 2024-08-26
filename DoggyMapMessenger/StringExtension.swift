//
//  StringExtension.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 24.04.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self) could not be found in Localization.strings")
    }
}
