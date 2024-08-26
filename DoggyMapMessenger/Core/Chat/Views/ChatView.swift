//import SwiftUI
//
//struct ChatView: View {
//    
//    @StateObject var viewModel: ChatViewModel
//    let user: User
//    @Binding var showDetailPage: Bool
//    
//    init(user: User, showDetailPage: Binding<Bool>){
//        self.user = user
//        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
//        self._showDetailPage = showDetailPage
//    }
//    
//    var body: some View {
//        VStack {
//            ScrollView{
//                // header
//                VStack(spacing: 4){
//                    CircularProfileImageView(user: user, size: .xLarge)
//                    
//                    Text("\(user.name) \(user.surname)")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    
//                    Text("Messenger")
//                        .font(.footnote)
//                        .foregroundStyle(.gray)
//                }
//                
//                // messages
//                LazyVStack {
//                    ForEach(viewModel.messages){ message in
//                        ChatMessageCellView(message: message)
//                    }
//                }
//            }
//            
//            // message input view
//            Spacer()
//            
//            ZStack(alignment: .trailing){
//                TextField("Message...", text: $viewModel.messageText, axis: .vertical) // axis для растягивания поля
//                    .padding(12)
//                    .padding(.trailing, 48)
//                    .background(Color(.systemGroupedBackground))
//                    .clipShape(Capsule())
//                    .font(.subheadline)
//                    .onTapGesture {
//                        showDetailPage = true
//                    }
//                
//                Button(action: {
//                    viewModel.sendMessage()
//                    viewModel.messageText = ""
//                    showDetailPage = false
//                }){
//                    Text("Send")
//                        .fontWeight(.semibold)
//                }
//                .padding(.horizontal)
//            }
//            .padding()
//        }
//        .navigationTitle("\(user.name) \(user.surname)")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//#Preview {
//    ChatView(user: User.MOCK_USER, showDetailPage: .constant(false))
//}

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel: ChatViewModel
    let user: User
    @Binding var showMessagePage: Bool
    
    init(user: User, showMessagePage: Binding<Bool>){
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
        self._showMessagePage = showMessagePage
    }
    
    var body: some View {
        VStack {
            ScrollView{
                VStack(spacing: 4){
                    CircularProfileImageView(user: user, size: .xLarge)
                    
                    Text("\(user.name) \(user.surname)")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Messenger")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                
                LazyVStack {
                    ForEach(viewModel.messages){ message in
                        ChatMessageCellView(message: message)
                    }
                }
            }
            
            Spacer()
            
            ZStack(alignment: .trailing){
                
                    TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                        .padding(12)
                        .padding(.trailing, 48)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(Capsule())
                        .font(.subheadline)
                        .onTapGesture {
                            showMessagePage = true
                        }
                
                
                Button(action: {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                    showMessagePage = false
                }){
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
            .offset(y: showMessagePage ? -60 : 0)
        }
        .navigationTitle("\(user.name) \(user.surname)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
