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
    var allCoins: [CoinModel] = []
    var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriver()
        
    }
    
    func addSubscriver() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
