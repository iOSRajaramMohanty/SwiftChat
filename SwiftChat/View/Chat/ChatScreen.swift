//
//  ChatScreen.swift
//  SwiftChat
//
//  Created by Rajaram on 08/05/23.
//

import SwiftUI

struct ChatScreen: View {
    @EnvironmentObject private var userInfo: UserInfo
    @StateObject private var model = ChatScreenModel() // <- this here
    @State private var message = ""
    
    private func onAppear() {
        model.connect(username: userInfo.username, userID: userInfo.userID)
    }
    
    private func onDisappear() {
            model.disconnect()
    }
    
    private func onCommit() {
        if !message.isEmpty {
            model.send(text: message)
            message = ""
        }
    }
    
    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        if let lastMessage = model.messages.last { // 4
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(lastMessage.id, anchor: .bottom) // 5
            }
        }
    }
    
    var body: some View {
        VStack {
            // Chat history.
            ScrollView { // 1
                ScrollViewReader { proxy in // 1
                        LazyVStack(spacing: 8) {
                            ForEach(model.messages) { message in
                                // This one right here 👇, officer.
                                ChatMessageRow(message: message, isUser: message.userID == userInfo.userID)
                                    .id(message.id)
                            }
                        }
                        .onChange(of: model.messages.count) { _ in // 3
                            scrollToLastMessage(proxy: proxy)
                        }
                    }
            }

            // Message field.
            HStack {
                TextField("Message", text: $message, onEditingChanged: { _ in }, onCommit: onCommit) // 2
                    .padding(10)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)
                
                Button(action: onCommit) { // 3
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 20))
                }
                .padding()
                .disabled(message.isEmpty) // 4
            }
            .padding()
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
}

