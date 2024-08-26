//
//  MapView.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 30.03.2023.
//

import SwiftUI
import MapKit

class HapticManager{ // Класс для работы TapticEngine
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}




struct MapView: View {
    //    init(){
    //        UINavigationBar.setAnimationsEnabled(false)
    //    }
    
    @State var selectedTab = "magnifyingglass"
    @State var isTapped = false
    @State var placeIsSelected = false
    @State var placeInfoShow = false
    
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    
    var body: some View {
        
        
        ZStack(alignment: .bottom){

            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                
                Spacer()

            }
            .sheet(item: $vm.sheetLocation, onDismiss: nil){ location in
                LocationDetailView(location: location)
            }
            
        }  
    }
}






struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(LocationsViewModel())
    }
}


extension MapView {
    
    private var header: some View{
            VStack{
                ForEach(vm.locations){ location in
                    if vm.mapLocation == location {
                        Button(action: {
                            vm.toggleLocationList()
                        }){
                            Text(vm.mapLocation.name)
                                .font(Font.custom("Avenir", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .animation(.none, value: vm.mapLocation)
                            
                                .overlay(alignment: .leading){
                                    Image(systemName: "arrow.down")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding()
                                        .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                                }
                            
                                .overlay(alignment: .trailing){
                                    Button(action: {
                                        //                                self.placeInfoShow.toggle()
                                        vm.sheetLocation = location
                                    }){
                                        Image(systemName: "info")
                                            .font(.title2)
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .padding()
                                            .frame(width: 45, height: 45)
                                        
                                    }
                                    
                                }
                        }
                    }
                }
        
                
                if vm.showLocationList{
                    LocationsListView()
                }

            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(
                color: Color.black.opacity(0.3),
                radius: 20,
                x: 0, y: 0)
            .padding(.horizontal, 15)
    }
    
    
    
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in // метки на карте
//            MapAnnotation(coordinate: location.coordinates){
            MapAnnotation(coordinate: location.coordinates){
//                        Text("O")
//                            .bold()
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.6) // Увеличение при выборе
                    .shadow(radius: 3)
                    .onTapGesture { // Переход при нажатии
                        placeIsSelected = true
                        vm.showNextLocation(location: location)
                        HapticManager.instance.impact(style: .heavy)
                        // soft
                        // light
                        // heavy
                        // medium
                        // rigid
                    }
                
            }
        })
    }
    
    
    
    
    
    private var locationsPreviewStack: some View{
        ZStack{

            ForEach(vm.locations){ location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding(.horizontal)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
    
    
    
    private var locationsDetail: some View{
        ZStack{
            
            ForEach(vm.locations){ location in
                if vm.mapLocation == location {
                    LocationDetailView(location: location)
                }
            }
        }
    }
    
    
}
