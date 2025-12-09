//
// KindCard.swift
// Real KAOS App
//
// Created by Courey Jimenez on 12/5/25.
//

import SwiftUI

struct KindCard : View {
    private let cardBackgroundColor = Color(red: 0.98, green: 0.97, blue: 0.93)
    private let cardOutlineColor = Color(red: 0.76, green: 0.53, blue: 0.23)
    private let categoryGradient = LinearGradient(
        colors: [Color(red: 0.97, green: 0.77, blue: 0.38), Color(red: 0.89, green: 0.39, blue: 0.08)],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    private let borderGradient = LinearGradient(
        colors: [
            Color(red: 0.98, green: 0.55, blue: 0.25),
            Color(red: 0.5, green: 0.0, blue: 0.13)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    var kindnessCard : Kindness
    
    var body: some View {
        
        ZStack {
            Color.burntOrange.edgesIgnoringSafeArea(.all)
            
            ForEach(1...3, id: \.self) { index in
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 0.95, green: 0.70, blue: 0.45))
                    .frame(width: 325, height: 450)
                    .rotationEffect(.degrees(Double(index * 2)))
                    .offset(x: CGFloat(index * 5), y: CGFloat(index * 5))
                    .shadow(radius: 5)
            }
            
            VStack(spacing: 50) {
//CATEGORY
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(categoryGradient)
                        .frame(width: 320, height: 60)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3))
                    
                    Text(kindnessCard.category.uppercased())
                        .bold()
                        .font(.custom("Lexend-Bold", size: 24))
                        .foregroundColor(.white)
                }
                .offset(y: -30)
                .zIndex(1)
                
//TASK
                VStack(alignment: .center) {
                    
                    Image(kindnessCard.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.top, 10)
                        .padding(.trailing, 275)
                    
                    Spacer()
                    
                    Text(kindnessCard.task)
                        .font(.custom("Lexend-Medium", size: 18))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    Image(kindnessCard.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.bottom, 10)
                        .padding(.leading, 275)
                }
                .frame(width: 325, height: 450)
               
                .background(Color.white)
                .cornerRadius(15)
                
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(borderGradient, lineWidth: 5)
                )
                .shadow(radius: 8)
                .offset(y: -30)
            }
        }
    }
}

#Preview {
    KindCard(kindnessCard: Kindness(
        category: "SIMPLE",
        image: "yellowFlame",
        task: "Give a genuine, specific compliment to a stranger or an acquaintance. Focus on something they chose (e.g., their shirt, a project they worked on), not just an inherent trait."
    ))
}
