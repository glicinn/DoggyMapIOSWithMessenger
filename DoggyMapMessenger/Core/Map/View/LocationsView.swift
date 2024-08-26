//
//  LocationsView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 01.04.2023.
//

import SwiftUI


struct LocationsView: View {
    
//    @StateObject private var vm = LocationsViewMoel()
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations){
                Text($0.name)
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
