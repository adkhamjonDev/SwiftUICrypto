//
//  CoinImageService.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 19/11/24.
//
import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    
    private let imageUrl: String
    
    init(urlString:String) {
        self.imageUrl = urlString
        getCoinImage(urlString: urlString)
    }
    
    private func getCoinImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
    
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap( { (data) -> UIImage? in
                return UIImage(data: data)
            })
        
            .sink { (completion) in
                NetworkingManager.handleCompletion(completion: completion)
            
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            }
    }
}
