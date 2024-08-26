//
//  InboxRowView.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 08.05.2024.
//

import SwiftUI

struct InboxRowView: View {
    
    let message: Message
    @Binding var showDetailPage: Bool
    
    var body: some View {
        Button(action: {
            showDetailPage = true
        }){
            HStack(alignment: .top, spacing: 12){
                CircularProfileImageView(user: message.user, size: .medium)
                
                VStack(alignment: .leading, spacing: 4){
                    Text("\(message.user?.name ?? "") \(message.user?.surname ?? "")" )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(message.messageText)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
                    // - 100 для правого маркера с данными, когда было последнее сообщение
                }
                
                HStack{
                    Text(message.timestampString)
                    
                    Image(systemName: "chevron.right")
                }
                .font(.footnote)
                .foregroundStyle(.gray)
            }
            .frame(height: 72)
        }
        
        
    
    }
}

//#Preview {
//    InboxRowView()
//}
