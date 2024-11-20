//
//  MarketDataService.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 20/11/24.
//

import Foundation
import Combine

class MarketDataService{
    @Published var marketData: MarketDataModel? = nil
    
    var marketSubscription: AnyCancellable?
    
    init() {
        getMarket()
    }
    
    private func getMarket() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
    
        marketSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink { (completion) in
                NetworkingManager.handleCompletion(completion: completion)
            
            } receiveValue: { [weak self] (returnedGlobal) in
                self?.marketData = returnedGlobal.data
                self?.marketSubscription?.cancel()
            }
           
    }
}
