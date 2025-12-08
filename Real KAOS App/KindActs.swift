//
//  KindActs.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/5/25.
//

import SwiftUI

struct KindActs: View {
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                Color.burntOrange.edgesIgnoringSafeArea(.all)
                
                VStack{
                    HStack{
                        Image(.yellowFlame)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Image(.orangeFlame)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Image(.redFlame)
                            .resizable()
                            .scaledToFit()
                            .frame( height: 50)
                    }
                    .padding()
                    
                    Text("Pick an act of kindness you'd like to pay forward!").multilineTextAlignment(.center)
                        .font(.custom("Lexend-Bold", size: 20))
                    
                }
            }
        }
    }
}
#Preview {
    KindActs()
}
