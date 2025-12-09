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
        ZStack{
            Color.burntOrange.edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 325, height: 75)
                .foregroundStyle(Color(.orange).opacity(0.3))
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.burgundy, lineWidth: 3))
                .overlay(Text(kindnessCard.category).bold()
                    .font(Font.custom("Lexend-ExtraBold", size: 35)))
                .padding(.bottom, 600)
            
            VStack(alignment: .center){
                Image(kindnessCard.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 275)
                    .padding(.bottom, 75)
                    .padding(.top, 10)
                
                Text(kindnessCard.task)
                    .multilineTextAlignment(.center).padding(EdgeInsets( top: 0, leading: 25, bottom: 0, trailing: 25))
                
                Image(kindnessCard.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 275)
                    .padding(.bottom, 10)
                    .padding(.top, 75)
            }
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
            
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.burgundy, lineWidth: 4))
            .padding(EdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 35))
        }
    }
}
#Preview {
    KindCard(kindnessCard: Kindness(category: "Category", image: "yellowFlame", task: "Give a genuine, specific compliment to a stranger or an acquanintance. Focus on something they chose (e.g., a project they worked on) not just an inherent trait."))
}
