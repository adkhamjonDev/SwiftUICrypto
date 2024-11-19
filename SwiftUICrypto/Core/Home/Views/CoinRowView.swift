//
//  CoinRowView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin:CoinModel
    
    let showHoldingColumns:Bool
    
    var body: some View {
        HStack(spacing: 0) {
            
            leftColumn
            Spacer()
            
            if showHoldingColumns {
                centerColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout){
   
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumns: true)

}

#Preview(traits: .sizeThatFitsLayout){
   
    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumns: true)
        .preferredColorScheme(.dark)
        .colorScheme(.dark)

}

extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0){
            Text(coin.rank.toString())
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImage(imageUrl: coin.image,imageName: coin.id)
                .frame(width: 30,height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn : some View {
        
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3,alignment: .trailing)
    }
}
