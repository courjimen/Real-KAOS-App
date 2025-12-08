//
//  KindCard.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/5/25.
//

import SwiftUI

struct KindCard : View {
    var kindnessCard : Kindness
    var body: some View {
        VStack(alignment: .center) {
            Text(kindnessCard.category).bold()
                .font(Font.custom("Lexend-ExtraBold", size: 35))
           
            Image(kindnessCard.image)
                .resizable()
                .scaledToFit()
                .padding()
                .overlay(Text(kindnessCard.task)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets( top: 0, leading: 50, bottom: 0, trailing: 50)))
                    .font(.custom("Lexend-Medium", size: 18))
        }
    }
}
#Preview {
    KindCard(kindnessCard: Kindness(category: "Category", image: "card", task: "Give a genuine, specific compliment to a stranger or an acquanintance. Focus on something they chose (e.g., a project they worked on) not just an inherent trait."))
}
