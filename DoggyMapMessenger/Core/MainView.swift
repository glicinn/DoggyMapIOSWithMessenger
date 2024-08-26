//
//  MainView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 19.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var vm = LocationsViewModel()
    @State private var tabSelection = 1
    @State var showDetailPage = false
    @State var showMessagePage = false
    
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            TabView(selection: $tabSelection){
                MapView()
                    .tag(1)
                    .environmentObject(vm)
//                NewsFirebaseView(showDetailPage: $showDetailPage)
//                    .tag(2)
                
                NewsView(showDetailPage: $showDetailPage)
                    .tag(2)
                WeatherContentView()
                    .tag(3)
                InboxView()
                    .tag(4)
            }
            .overlay(alignment: .bottom){
                CustomTabView(tabSelection: $tabSelection, showDetailPage: $showDetailPage, showMessagePage: $showMessagePage)
            }
        }


    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
