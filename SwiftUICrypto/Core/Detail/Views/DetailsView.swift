//
//  DetailsView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 21/11/24.
//

import SwiftUI

struct DetailLoadingView:View{
    @Binding var coin:CoinModel?
    var body: some View{
        ZStack {
            if let coin = coin{
                DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    
    @StateObject private var viewModel: DetailsViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing:CGFloat = 30
    
    @State var showFullDescription:Bool = false
    
    init(coin:CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailsViewModel(coinModel: coin))
        print("iNITIALIZING DETAIL VIEW FOR \(coin.name)")
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)

                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

#Preview {
    NavigationStack{
        DetailsView(coin: DeveloperPreview.instance.coin)
    }
}

extension DetailsView{
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImage(imageUrl: viewModel.coin.image, imageName: viewModel.coin.id)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = viewModel.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)

                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "Less" : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.overviewStats) { stat in
                    StatisticView(statistic: stat)
                }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.additionalStats) { stat in
                    StatisticView(statistic: stat)
                }
        })
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = viewModel.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = viewModel.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
            
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
