//
//  UserInfo.swift
//  SwiftChat
//
//  Created by Rajaram on 08/05/23.
//

import Combine
import Foundation

class UserInfo: ObservableObject {
    let userID = UUID()
    @Published var username = ""
}
