//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import SwiftUI

struct HomeView:View {
    
    @State private var showPortfolio: Bool = false
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    
    @State private var showPortfolioView:Bool = false // new sheeet
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    @State private var showSettings:Bool = false
    
    
    var body: some View{
        
        ZStack{
            
            // background
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView){
                    PortfolioView()
                        .environmentObject(viewModel)
                }
            
            // content layer
            
            VStack{
                
                homeHeader
                
                HomeStatsView(
                    showPortfolio: $showPortfolio
                )
                
                SearchbarView(searchText: $viewModel.searchText)
                
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
            .sheet(isPresented: $showSettings){
                SettingsView()
            }
            
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: {EmptyView()}
                
            )
        )
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .navigationBarHidden(true)
            .environmentObject(DeveloperPreview.instance.homeVm)
    }
    
    
}

extension HomeView{
    var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none,value: UUID())
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettings.toggle()
                    }
                }
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
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin:CoinModel) {
        showDetailView.toggle()
        selectedCoin = coin
        
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(viewModel.portfolioCoins){ coin in
                
                CoinRowView(coin: coin, showHoldingColumns: true)
                    .listRowInsets(.init(
                        top:10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10
                    ))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture{
                withAnimation(.default){
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio{
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                    
                }
                .frame(width: UIScreen.main.bounds.width / 3,alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default){
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                        
                    }
                }
                
            }
            
            HStack(spacing: 4) {
                Text("Price")
                   
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3,alignment: .trailing)
            .onTapGesture {
                withAnimation(.default){
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            
            
            Button(
                action:{
                    withAnimation(.linear(duration: 2.0)){
                        viewModel.reloadData()
                    }
                }, label: {
                    Image(systemName: "goforward")
                }
            )
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0),anchor: .center)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
