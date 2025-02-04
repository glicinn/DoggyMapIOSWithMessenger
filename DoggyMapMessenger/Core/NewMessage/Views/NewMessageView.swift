//
//  NewMessageView.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 08.05.2024.
//

import SwiftUI

struct NewMessageView: View {
    
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView{
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("Contacts".uppercased())
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(viewModel.users){ user in
                    VStack{
                        HStack {
                            CircularProfileImageView(user: user, size: .small)

                            Text("\(user.name) \(user.surname)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.vertical, 5)
                        
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
                
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        dismiss()
                    }){
                        Text("Cancel")
                            .foregroundStyle(.primary)
                    }
                    .foregroundStyle(.black)
                }
        }
        }
    }
}

#Preview {
    NavigationStack{
        NewMessageView(selectedUser: .constant(User.MOCK_USER))
    }
}
