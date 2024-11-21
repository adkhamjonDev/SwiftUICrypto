//
//  XMarkButton.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 21/11/24.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        Button(
            action: {
                presentationMode.wrappedValue.dismiss()
            },
            label: {
                
                Image(systemName: "xmark")
            }
        )
    }
}

#Preview {
    XMarkButton()
}
