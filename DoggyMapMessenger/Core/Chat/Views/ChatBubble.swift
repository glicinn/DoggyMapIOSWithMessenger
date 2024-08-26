//
//  ChatBubbleView.swift
//  DoggyMapMessenger
//
//  Created by Дмитрiй Дѣренъ on 10.05.2024.
//

import SwiftUI

struct ChatBubble: Shape {
    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [
                                    .topLeft,
                                    .topRight,
                                    isFromCurrentUser ? .bottomLeft : .bottomRight
                                ],
                                cornerRadii: CGSize(width: 16, height: 16 ))
        
        return Path(path.cgPath)
    }
}

struct ChatBubble_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ChatBubble(isFromCurrentUser: true)
                .frame(width: 200, height: 100) // Примерный размер для предварительного просмотра
                .previewLayout(.sizeThatFits)
            
            ChatBubble(isFromCurrentUser: false)
                .frame(width: 200, height: 100) // Примерный размер для предварительного просмотра
                .previewLayout(.sizeThatFits)
        }
    }
}
