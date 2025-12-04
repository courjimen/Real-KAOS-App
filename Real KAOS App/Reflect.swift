//
//  SwiftUIView.swift
//  Real KAOS App
//
//  Created by Bianca Noel on 12/3/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack{
            Color.burntOrange.edgesIgnoringSafeArea(.all)
                .opacity(0.15)
            VStack{
              Text("Reflection")
                    .font(.custom("lexend-Bold" ,size:50))
                    .padding(30)
                    .offset(y:-250)
                
                Text ("You are working on a group project, and one teammate consistently submits their parts late, forcing you to rush to meet the deadline.")
                    .font(.custom("Lexend-Bold",size: 24))
                    .offset(y:-250)
                Text ("What Emotion are you most likely feeling right now?")
                    .font(.custom("Lexend-Bold",size: 24))
                    .padding(20)
                    .offset(y:-250)
                
            }
        }
        
        
        
    }
}
#Preview {
    SwiftUIView()
}

