//
//  CoinDetailsDataService.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 21/11/24.
//
import Foundation
import Combine


class CoinDetailsDataService {
    @Published var detail: CoinDetailModel?=nil
    
    var coinDetailSubscription: AnyCancellable?
    let coinId:String
    
    init(coinId:String) {
        self.coinId = coinId
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coinId)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
    
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                NetworkingManager.handleCompletion(completion: completion)
            
            } receiveValue: { [weak self] (returnedCoins) in
                self?.detail = returnedCoins
                self?.coinDetailSubscription?.cancel()
            }
           
    }
}
