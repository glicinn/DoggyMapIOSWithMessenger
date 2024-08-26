//
//  LocationMapAnnotationView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 02.04.2023.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let pinColor = Color("PinColor")
    
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "circle.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(pinColor)
                .padding()

        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView()
    }
}
