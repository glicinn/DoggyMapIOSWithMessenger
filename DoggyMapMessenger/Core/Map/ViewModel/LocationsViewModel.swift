//
//  LocationsViewModel.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 01.04.2023.
//

import SwiftUI
import MapKit
import Foundation

class LocationsViewModel: ObservableObject {
    
    //All loaded locations
    @Published var locations: [Location]
    
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation) // Сохранение локации, выбранной пользователем
        }
    }
    
//    @Published var startLocation: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.752615, longitude: 37.621825), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)) // зум
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    var mapSpan = MKCoordinateSpan(latitudeDelta: 0.066, longitudeDelta: 0.066)
//    @Published var mapRegion:  MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.752615, longitude: 37.621825), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    
    
    
    // Show list of locations
    @Published var showLocationList: Bool = false
    
    // Show location detail
    @Published var sheetLocation: Location? = nil
    
    
    init(){
        let locations = LocationsDataService.locations
//        let locations = model.list
        self.locations = locations
        self.mapLocation = locations.first! // Чтобы mapLocation была первой в списке
        
        
        self.updateMapRegion(location: Location(name: "", cityName: "", coordinates: CLLocationCoordinate2D(latitude: 55.752615, longitude: 37.62), description: "", imageNames: [""], link: ""))
//        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){ 
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    
    func toggleLocationList(){
        withAnimation(.easeInOut){
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed(){
        // $0 == location
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation}) else {
            print("Couldn't find index in locations array! Should never happen")
            return
        }
        
        
        // Check if currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //Next index is not valid
            // Restart from 0
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }

}
