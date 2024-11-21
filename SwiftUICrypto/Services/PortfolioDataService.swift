//
//  PortfolioDataService.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 21/11/24.
//
import Foundation
import CoreData

class PortfolioDataService {
    private let container:NSPersistentContainer
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "PortfolioContainer")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC
    
    
    
    func updatePortfolio(coin:CoinModel,amount:Double) {
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            if amount > 0{
                update(entitiy: entity, amount: amount)
            } else {
                remove(entitiy: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
        
        // same things
//            if let entity = savedEntities.first(where: {
//                (savedEntity) -> Bool in
//                return savedEntity.coinID == coin.id
//            })
    }
    
    
    // MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: "PortfolioEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error getching Portfolio Entities. \(error)")
        }
    }
    
    private func add(coin:CoinModel, amount:Double) {
        let entitity = PortfolioEntity(context: container.viewContext)
        entitity.coinID = coin.id
        entitity.amount = amount
        applyChanges()
    }
    
    private func update(entitiy:PortfolioEntity,amount:Double) {
        entitiy.amount = amount
        applyChanges()
    }
    
    private func remove(entitiy:PortfolioEntity) {
        container.viewContext.delete(entitiy)
        applyChanges()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error savinf Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
