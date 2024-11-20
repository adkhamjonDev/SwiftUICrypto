//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//

import Foundation
import Observation
import Combine

@Observable class HomeViewModel{
    
    var stats:[StatisticModel] = []
    
    var allCoins: [CoinModel] = []
    var portfolioCoins: [CoinModel] = []
    
    var searchText:String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init() {
        addSubscriver()
    }
    
    func addSubscriver() {
        coinDataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.stats = returnedStats
            }
            .store(in: &cancellables)


    }
    
    private func mapGlobalMarketData(marketModel: MarketDataModel?) -> [StatisticModel] {
        var stats:[StatisticModel] = []
        
        guard let data = marketModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title:"Market Cap",value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00",percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,volume,btcDominance,portfolio
        ])
        return stats
    }
}


//        searchText
//            .combineLatest(dataService.$allCoins)
//            .map{(text,startingCoins) -> [CoinModel] in
//
//                guard !text.isEmpty else {
//                    return startingCoins
//                }
//                let lowerCasedText = text.lowercased()
//
//                return startingCoins.filter { (coin) -> Bool in
//                    return coin.name.lowercased().contains(lowerCasedText) ||
//                    coin.symbol.lowercased().contains(lowerCasedText) ||
//                    coin.id.lowercased().contains(lowerCasedText)
//                }
//            }
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }

