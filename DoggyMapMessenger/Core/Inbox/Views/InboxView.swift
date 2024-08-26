////
////  InboxView.swift
////  DoggyMapMessenger
////
////  Created by Дмитрiй Дѣренъ on 08.05.2024.
////
//
//import SwiftUI
//
//struct InboxView: View {
//    
//    @State private var showNewMessageView: Bool = false
//    @StateObject var viewModel = InboxViewModel()
//    @State private var selectedUser: User?
//    @State private var showChat = false
//    @State private var showDetailPage: Bool = false
//    
//    private var user: User? {
//        return viewModel.currentUser
//    }
//    
//    var body: some View {
//        NavigationStack{
//            List {
//                ActiveNowView()
//                    .listRowSeparator(.hidden)
//                    .listRowInsets(EdgeInsets())
//                    .padding(.vertical)
//                    .padding(.horizontal, 4)
//                
//                ForEach(viewModel.recentMessages) { message in
//                    ZStack {
//                        NavigationLink(value: message){
//                            EmptyView()
//                        }.opacity(0.0)
//                        
//                        InboxRowView(message: message, showDetailPage: $showDetailPage)
//                            .onTapGesture {
//                                        showDetailPage = true
//                                    }
//                    }
//                }
//            }
//            .navigationTitle("Chats")
//            .navigationBarTitleDisplayMode(.inline)
//            
//            .listStyle(PlainListStyle())
//            .onChange(of: selectedUser, perform: { newValue in
//                showChat = newValue != nil
//            })
//            .navigationDestination(for: Message.self, destination: { message in
//                if let user = message.user {
//                    ChatView(user: user, showDetailPage: $showDetailPage)
//                }
//            })
//            .navigationDestination(for: Route.self, destination: { route in
//                switch route {
//                case .profile(let user):
//                    ProfileView(user: user)
//                case .chatView(let user):
//                    ChatView(user: user, showDetailPage: $showDetailPage)
//                }
//            })
//            .navigationDestination(isPresented: $showChat, destination: {
//                if let user = selectedUser{
//                    ChatView(user: user, showDetailPage: $showDetailPage)
//                }
//            })
//            .fullScreenCover(isPresented: $showNewMessageView, content: {
//                NewMessageView(selectedUser: $selectedUser)
//            })
//            .toolbar{
//                ToolbarItem(placement: .topBarLeading) {
//                    HStack{
//                        if let user {
//                            NavigationLink(value: Route.profile(user)) {
//                                CircularProfileImageView(user: user, size: .xSmall)
//                            }
//                        }
//                        
////                        Text("Chats")
////                            .font(.title)
////                            .fontWeight(.semibold)
//                    }
//                }
//                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: {
//                        showNewMessageView.toggle()
//                        selectedUser = nil
//                    }){
//                        Image(systemName: "square.and.pencil.circle.fill")
//                            .resizable()
//                            .frame(width: 32, height: 32)
//                            .foregroundStyle(.black, Color(.systemGray5))
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    InboxView()
//}


import SwiftUI

struct InboxView: View {
    
    @State private var showNewMessageView: Bool = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    @State private var showDetailPage: Bool = false
    @State private var showMessagePage: Bool = false
    @State private var tabSelection: Int = 1
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    ActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical)
                        .padding(.horizontal, 4)
                    
                    ForEach(viewModel.recentMessages) { message in
                        ZStack {
                            NavigationLink(value: message){
                                EmptyView()
                            }.opacity(0.0)
                            
                            InboxRowView(message: message, showDetailPage: $showDetailPage)
                        }
                    }
                }
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle())
                .onChange(of: selectedUser, perform: { newValue in
                    showChat = newValue != nil
                })
                .navigationDestination(for: Message.self, destination: { message in
                    if let user = message.user {
                        ChatView(user: user, showMessagePage: $showMessagePage)
                    }
                })
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .profile(let user):
                        ProfileView(user: user)
                    case .chatView(let user):
                        ChatView(user: user, showMessagePage: $showMessagePage)
                    }
                })
                .navigationDestination(isPresented: $showChat, destination: {
                    if let user = selectedUser {
                        ChatView(user: user, showMessagePage: $showMessagePage)
                    }
                })
                .fullScreenCover(isPresented: $showNewMessageView, content: {
                    NewMessageView(selectedUser: $selectedUser)
                })
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        HStack{
                            if let user {
                                NavigationLink(value: Route.profile(user)) {
                                    CircularProfileImageView(user: user, size: .xSmall)
                                }
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showNewMessageView.toggle()
                            selectedUser = nil
                        }){
                            Image(systemName: "square.and.pencil.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.black, Color(.systemGray5))
                        }
                    }
                }
                
            }
        }
    }
}
