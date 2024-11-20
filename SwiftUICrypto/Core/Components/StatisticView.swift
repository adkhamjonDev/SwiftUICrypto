//
//  StatisticView.swift
//  SwiftUICrypto
//
//  Created by Adkhamjon Rakhimov on 20/11/24.
//

import SwiftUI

struct StatisticView: View {
    let statistic:StatisticModel
    var body: some View {
        VStack(alignment: .leading,spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack {
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:
                         (statistic.percentageChange ?? 0) >= 0 ? 0 : 180
                        ))
                
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
                
            }
            .foregroundColor((statistic.percentageChange ?? 0) >= 0 ? Color.theme.green   : Color.theme.red)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        }
       
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group{
        StatisticView(statistic: DeveloperPreview.instance.stat1)
        StatisticView(statistic: DeveloperPreview.instance.stat2)
        StatisticView(statistic: DeveloperPreview.instance.stat3)
    }
}
