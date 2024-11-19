//
//  CoinImage.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import SwiftUI

struct CoinImage: View {
    @State var vm:CoinImageViewModel
    
    init(imageUrl: String,imageName:String) {
        _vm = State(wrappedValue: CoinImageViewModel(urlString: imageUrl,imageName: imageName))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(
                    uiImage: image
                )
                .resizable()
                .scaledToFit()
            } else if vm.isloading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText )
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImage(imageUrl:  DeveloperPreview.instance.coin.image,imageName: DeveloperPreview.instance.coin.id)
        .padding()
}
