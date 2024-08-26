//
//  LocationDetailView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 08.04.2023.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Выпвнивание по левой
                .padding()
                
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton ,alignment: .topLeading)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}





extension LocationDetailView{
    
    private var imageSection: some View{
        TabView{ // Для пролистывания фотографий
            ForEach(location.imageNames, id: \.self){
                Image($0)
                    .resizable()
                    .scaledToFill()
                
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped() // Чтоб не было фризов
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    
    
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(Font.custom("Avenir", size: 35))
//                            .font(.largeTitle)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(Font.custom("Avenir", size: 20))
//                            .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    
    
    
    private var descriptionSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.description)
                .font(Font.custom("Avenir", size: 15))
//                            .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link){
                Link("read-more-string".localized, destination: url)
//                    .font(.headline)
                    .font(Font.custom("Avenir", size: 17))
                    .fontWeight(.bold)
            }
        }
    }
    
    
    
    
    
    private var mapLayer: some View{
        
        Map(coordinateRegion: .constant(MKCoordinateRegion(
//            center: location.coordinates,
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))),
            annotationItems: [location]) { location in
//            MapAnnotation(coordinate: location.coordinates) {
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false) // Чтобы карта была неюзабельна
            .aspectRatio(1, contentMode: .fit) // Чтобы был квадрат
            .cornerRadius(30)
//            .shadow(color: Color.black.opacity(0.1), radius: 5)
    }
    
    
   
    
    
    private var backButton: some View{
        
        Button(action:{
//            vm.sheetLocation = nil
            dismiss()
        }){
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
    
}
