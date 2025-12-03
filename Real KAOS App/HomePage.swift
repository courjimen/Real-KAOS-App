//
//  HomePage.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/1/25.
//

import SwiftUI

struct HomePage: View {
    @State var heartButton = false
    
    var body: some View {
        ZStack { Color.burntOrange.edgesIgnoringSafeArea(.all)
                .opacity(0.15)
//            Button {
//            
//            } label: {
//                Image(systemName: "heart.fill")
//                    .resizable()
//                    .frame(width: 225, height: 175)
//                    .padding(.top, 170)
//                    .foregroundStyle(Color.burgundy)
//            }

//            Image(.redHeart)
//                .resizable()
//                .frame(width: 225, height: 175)
//                .padding(.top, 170)
//                .shadow(color: .black, radius: 10)
//                .overlay(Text("Do A Kind Act"))
               
                
            VStack (alignment: .center){
           
                Button {
                    heartButton.toggle()
                } label: {
                    Image(.yellowFlame)
                        .resizable()
                        .frame(width: 325, height: 435)
                }
                Text("Do A Kind Act")
                    .font(Font.custom("Lexend-Bold", size: 25))
                    .offset(y: -100)
                Text("You are feeling irritated right now")
                Text("Insert Affirmation").bold()
            
                HStack {
                    Image(.cloud)
                    Image(.cloud)
                }
            }
        }
    }
}

#Preview {
    HomePage()
}
