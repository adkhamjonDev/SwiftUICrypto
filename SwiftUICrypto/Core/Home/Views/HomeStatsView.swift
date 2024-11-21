//
//  HomeStatsView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 20/11/24.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var viewModel:HomeViewModel
    
    @Binding var showPortfolio:Bool
    
    var body: some View {
        HStack{
            ForEach(viewModel.stats){ stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview(traits: .sizeThatFitsLayout){
    HomeStatsView(showPortfolio: .constant(false))
}
