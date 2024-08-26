//
//  Today.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 31.03.2023.
//

import SwiftUI

// data model and sample data

struct Today: Identifiable{
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String
}

var todayItems: [Today] = [
    
    Today(appName: "Kitty", appDescription: "Mew", appLogo: "kitty", bannerTitle: "Kitty!", platformTitle: "Doggy Map", artwork: "kitty"),
    
    Today(appName: "Zlusya", appDescription: "Angry", appLogo: "angrydog1", bannerTitle: "Angry shpitz", platformTitle: "Doggy Map", artwork: "angrydog1"),
    
    Today(appName: "Dog's son", appDescription: "Really!?", appLogo: "dogsson", bannerTitle: "Dog's son", platformTitle: "Doggy Map", artwork: "dogsson"),
    
//    Today(appName: "Dog", appDescription: "Wow", appLogo: "doginglasses", bannerTitle: "Dog in glasses!", platformTitle: "Doggy Map", artwork: "doginglasses")
]


var dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
