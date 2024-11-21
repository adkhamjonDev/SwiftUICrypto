//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    @StateObject private var vm = HomeViewModel()
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
