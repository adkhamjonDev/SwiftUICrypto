//
//  PortfolioView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 21/11/24.
//

import SwiftUI

struct PortfolioView: View {

    @Environment(HomeViewModel.self) private var viewModel
    
    @State private var selectedCoin: CoinModel? = nil
    
    @State private var quantityText:String = ""
    @State private var showCheckMark:Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading,spacing: 0){
                    SearchbarView(searchText: .constant(""))
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    XMarkButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    trailingNavBarItems
                }
                
            }
        }
        
    }
}

#Preview {
    PortfolioView()
        .environment(DeveloperPreview.instance.homeVm)
}


extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHStack(spacing: 10){
                ForEach(viewModel.allCoins){ coin in
                    
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                                    lineWidth: 1.0)
                            
                        )
                }
            }
        }
        .frame(height: 120)
        .padding(.leading, 4)
    }
    
    
    private func getCurrentValue()-> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20){
            HStack(){
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amoun in your portfolio:")
                Spacer()
                TextField("Ex: 1.4",text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            
            HStack{
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none,value : UUID())
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarItems: some View {
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button(
                action: {
                    
                }, label : {
                    Text("save".uppercased())
                }
            )
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        
        guard let coin = selectedCoin else { return }
        
        // save portfolio
        
        // show checkmark
        
        withAnimation(.easeIn){
            showCheckMark = true
        }
        
        // hide keyboard
        
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            withAnimation(.easeOut){
                showCheckMark = false
            }
        }

        
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
