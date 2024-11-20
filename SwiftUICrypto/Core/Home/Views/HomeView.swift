//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import SwiftUI

struct HomeView:View {
    
    @State private var showPortfolio: Bool = false
    
    @Environment(HomeViewModel.self) private var viewModel
    
    @State var searchText:String = ""
    var body: some View{
       
        ZStack{

            // background
            Color.theme.background.ignoresSafeArea()
            
            // content layer
            
            VStack{
                
                homeHeader
                
                HomeStatsView(
                    showPortfolio: $showPortfolio
                )
                
                SearchbarView(searchText: $searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
               
                Spacer(minLength: 0)
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .navigationBarHidden(true)
            .environment(DeveloperPreview.instance.homeVm)
    }
        
    
}

extension HomeView{
    var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none,value: UUID())
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring){
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            ForEach(viewModel.allCoins){ coin in
            
                CoinRowView(coin: coin, showHoldingColumns: false)
                    .listRowInsets(.init(
                        top:10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10
                    ))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(viewModel.allCoins){ coin in
            
                CoinRowView(coin: coin, showHoldingColumns: true)
                    .listRowInsets(.init(
                        top:10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10
                    ))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3,alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
