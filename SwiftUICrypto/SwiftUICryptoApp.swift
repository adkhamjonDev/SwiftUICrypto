//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    @State private var vm:HomeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environment(vm)
        }
    }
}
