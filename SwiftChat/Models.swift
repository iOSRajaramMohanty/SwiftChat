//
//  Models.swift
//  SwiftChat
//
//  Created by Rajaram on 08/05/23.
//

import Foundation

struct SubmittedChatMessage: Encodable {
    let message: String
    let user: String // <- We
    let userID: UUID // <- are
}

struct ReceivingChatMessage: Decodable, Identifiable {
    let date: Date
    let id: UUID
    let message: String
    let user: String // <- new
    let userID: UUID // <- here
}
