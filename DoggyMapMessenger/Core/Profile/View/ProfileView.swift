//
//  ProfileView.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 08.05.2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    let user: User
    
    @State private var isCalendarPresented = false
    @State private var isDogsPresented = false
    
    var body: some View {
        VStack{
            // header
            VStack{
                PhotosPicker(selection: $viewModel.selectedItem){
                    if let profileImage = viewModel.profileImage{
                        profileImage
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: user, size: .xLarge)
                    }
                }
                
                HStack{
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(user.surname)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
            }
            
            // list
            
            List{
                
                Section{
                    Button(action: {
                        self.isCalendarPresented = true
                    }){
                        HStack{
                            Image(systemName: "calendar")
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 28, height: 28)
                                        .foregroundStyle(.purple)
                                )
                            
                            Text("calendar-string".localized)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding(.leading, 10)
                        }
                        
                    }
                    
                    
                    
                }
                
                

                
                Section{
                    
                    Button(action: {
                        self.isDogsPresented = true
                    }){
                        HStack{
                            Image(systemName: "person.fill")
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 28, height: 28)
                                        .foregroundStyle(.pink)
                                )
                            
                            Text("Accessibility")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding(.leading, 10)
                        }
                        
                    }
                    
                    ForEach(SettingsOptionsViewModel.allCases){ option in
                        HStack{
                            Image(systemName: option.imageName)
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 28, height: 28)
                                        .foregroundStyle(option.imageBackgroundColor)
                                )
                            
                            Text(option.title)
                                .font(.subheadline)
                                .padding(.leading, 10)
                        }
                    }
                }
                
                Section{
                    Button("Log Out"){
                        AuthService.shared.signOut()
                    }
                    
                    Button("Delete Account"){
                        
                    }
                }
                .foregroundStyle(.red)
            }
        }
        .sheet(isPresented: $isCalendarPresented) {
            CalendarView(user: user)
        }
        .sheet(isPresented: $isDogsPresented) {
            PetsView()
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
