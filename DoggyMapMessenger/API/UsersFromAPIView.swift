//
//  ContentView.swift
//  DoggyMapAPI
//
//  Created by Дмитрiй Дѣренъ on 01.05.2024.
//

import SwiftUI

struct UsersFromAPIView: View {
    
    @State private var user: DoggyMapUser?
    
    var body: some View {
        VStack {
            Text(user?.role.lowercased().capitalized ?? "Login Placeholder")
                .font(.largeTitle)
                .bold()
            HStack{
                Text(user?.userFirstName ?? "Name")
                    .font(.title)
                Text(user?.userLastName ?? "Surname")
                    .font(.title)
            }
            
            Text(user?.email ?? "Email")
                .foregroundStyle(.white)
                .bold()
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                )
            
            Text(user?.password ?? "Password")
                .padding(.top, 10)
            
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch DoggyMapErrors.invalidURL {
                print("Invalid URL")
            } catch DoggyMapErrors.invalidResponse {
                print("Invalid Response")
            } catch DoggyMapErrors.invalidData {
                print("Invalid Data")
            } catch {
                print("Unexpected Error")
            }
        }
        
    }
    
    
    //-------------------------
    
    
    func getUser() async throws -> DoggyMapUser{
        let endpoint = "https://amiable-reprieve-production.up.railway.app/api/users/3"
        
        guard let url = URL(string: endpoint) else {
            throw DoggyMapErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw DoggyMapErrors.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(DoggyMapUser.self, from: data)
        } catch {
            throw DoggyMapErrors.invalidData
        }
    }
    
    
    
}


//#Preview {
//    UsersFromAPIView()
//}

//------------------- Model ------------------------

struct DoggyMapUser: Codable{
    let email: String
    let password: String
    let userFirstName: String
    let userLastName: String
    let role: String
}

//--------------------- Errors ----------------------

enum DoggyMapErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
