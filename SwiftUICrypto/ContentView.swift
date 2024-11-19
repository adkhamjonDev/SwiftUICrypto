//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 40){
                
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Secondary Text Color")
                    .foregroundColor(Color.theme.secondaryText)
                
                Text("Red Color")
                    .foregroundColor(Color.theme.red)
                
                Text("Green Color")
                    .foregroundColor(Color.theme.green)
                
            }
            
        }
    }
}

#Preview {
    ContentView()
}
