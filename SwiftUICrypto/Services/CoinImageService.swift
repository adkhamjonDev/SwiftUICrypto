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
    
    private let fileManager = LocalFileManager.instance
    
    private let folderName = "coin_images"
    
    private let imageName: String
    
    init(urlString:String,imageName:String) {
        self.imageUrl = urlString
        self.imageName = imageName
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image from File manager!")
        } else {
            
            print("Downloading image now")
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: imageUrl) else { return }
    
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap( { (data) -> UIImage? in
                return UIImage(data: data)
            })
        
            .sink { (completion) in
                NetworkingManager.handleCompletion(completion: completion)
            
            } receiveValue: { [weak self] (returnedImage) in
                
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            }
    }
}
