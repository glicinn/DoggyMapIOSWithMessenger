//
//  Location.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 01.04.2023.
//

import Foundation
import MapKit



struct Location: Identifiable, Equatable {


//    let id = UUID().uuidString
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String

    // Identifiable
    var id: String{
        name + cityName
    }

    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}


