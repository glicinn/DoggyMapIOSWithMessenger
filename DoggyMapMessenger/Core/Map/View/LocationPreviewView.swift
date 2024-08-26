//
//  LocationPreviewView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 01.04.2023.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0){
            VStack(alignment: .leading,spacing: 5){
                imageSection
                titleSection
            }
            
            VStack(spacing: 8){
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 70)
        )
        .cornerRadius(10)
    }
}






struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationsViewModel())
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.black)
        .cornerRadius(15)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading){
            Text(location.name)
                .font(Font.custom("Avenir", size: 22))
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button{
            vm.sheetLocation = location
        } label: {
            Text("Learn more")
                .font(Font.custom("Avenir", size: 20))
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
        .tint(.black)
    }
    
    private var nextButton: some View {
        Button{
//            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(Font.custom("Avenir", size: 20))
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.bordered)
        .tint(.black)
    }
}
