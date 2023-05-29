//
//  ChatMessageRow.swift
//  SwiftChat
//
//  Created by Rajaram on 08/05/23.
//

import SwiftUI

struct ChatMessageRow: View {
    
    let message: ReceivingChatMessage
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(message.user)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                    
                    Text(DateFormatter.dateFormatter.string(from: message.date))
                        .font(.system(size: 10))
                        .opacity(0.7)
                }
                
                Text(message.message)
            }
            .foregroundColor(isUser ? .white : .black)
            .padding(10)
            .background(isUser ? Color.blue : Color(white: 0.95))
            .cornerRadius(5)
            
            if !isUser {
                Spacer()
            }
        }
    }
}

