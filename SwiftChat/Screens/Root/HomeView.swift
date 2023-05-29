//
//  ContentView.swift
//  SwiftChat
//
//  Created by Rajaram on 08/05/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var userInfo = UserInfo() // 1
    
    var body: some View {
        //        ChatScreen()
        NavigationView {
            SettingsScreen()
        }
        .environmentObject(userInfo) // 2
        .navigationViewStyle(StackNavigationViewStyle()) // 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
