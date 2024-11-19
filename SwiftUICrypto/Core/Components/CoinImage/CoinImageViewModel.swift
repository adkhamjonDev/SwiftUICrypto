//
//  CoinImageViewModel.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//


import Observation
import SwiftUI
import Combine

@Observable class CoinImageViewModel {
    var image: UIImage?=nil
    var isloading: Bool = false
    
    private var imageUrl:String
    
    private let coinImageService: CoinImageService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(urlString: String,imageName:String) {
        self.imageUrl = urlString
        self.coinImageService = CoinImageService(urlString: urlString, imageName: imageName)
        addSubscriber()
    }
    
    private func addSubscriber() {
        coinImageService.$image
            .sink { [weak self] (_) in
                self?.isloading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellable)
    }
}
