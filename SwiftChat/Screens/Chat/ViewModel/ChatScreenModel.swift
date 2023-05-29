//
//  ChatScreenModel.swift
//  SwiftChat
//
//  Created by Rajaram on 08/05/23.
//

import Combine
import Foundation

final class ChatScreenModel: ObservableObject {
    private var username: String?
    private var userID: UUID?
    private var webSocketTask: URLSessionWebSocketTask? // 1
    @Published private(set) var messages: [ReceivingChatMessage] = []
    
    // MARK: - Connection
    func connect(username: String, userID: UUID) { // 2
        self.username = username
        self.userID = userID
        let url = URL(string: "ws://127.0.0.1:8080/chat")! // 3
        webSocketTask = URLSession.shared.webSocketTask(with: url) // 4
        webSocketTask?.receive(completionHandler: onReceive) // 5
        webSocketTask?.resume() // 6
    }
    
    func disconnect() { // 7
        webSocketTask?.cancel(with: .normalClosure, reason: nil) // 8
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive) // 1
        
        if case .success(let message) = incoming { // 2
            onMessage(message: message)
        }
        else if case .failure(let error) = incoming { // 3
            print("Error", error)
        }
    }
    
    private func onMessage(message: URLSessionWebSocketTask.Message) { // 4
        if case .string(let text) = message { // 5
            guard let data = text.data(using: .utf8),
                  let chatMessage = try? JSONDecoder().decode(ReceivingChatMessage.self, from: data)
            else {
                return
            }
            
            DispatchQueue.main.async { // 6
                self.messages.append(chatMessage)
            }
        }
    }
    
    deinit { // 9
        disconnect()
    }
    
    func send(text: String) {
        guard let username = username, let userID = userID else { // Safety first!
            return
        }
        let message = SubmittedChatMessage(message: text, user: username, userID: userID) // 1
        guard let json = try? JSONEncoder().encode(message), // 2
              let jsonString = String(data: json, encoding: .utf8)
        else {
            return
        }
        
        webSocketTask?.send(.string(jsonString)) { error in // 3
            if let error = error {
                print("Error sending message", error) // 4
            }
        }
    }
}
