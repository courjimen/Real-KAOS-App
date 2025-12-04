
//
//  ContentView.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/1/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    var body: some View {
        NavigationStack {
            ZStack{
                Color.burntOrange.edgesIgnoringSafeArea(.all)
                    .opacity(0.15)
                
                VStack {
                    Image(.kaosLogo)
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    Text("How are you feeling?")
                        .font(.custom("Lexend-Bold", size: 20))
                        .dynamicTypeSize(.accessibility1)
                    
                    //BUTTON
                    NavigationLink(destination: HomePage()){
                        Image(.yellowFlame)
                            .resizable()
                            .frame(width: 75, height: 125)
                    }
                    Text("Calm")
                        .font(.custom("Lexend-Regular", size: 20))
                        .dynamicTypeSize(.accessibility1)                    //BUTTON
                    NavigationLink(destination: Breathing()){
                        Image(.orangeFlame)
                            .resizable()
                        .frame(width: 75, height: 125)}
                    Image(.cloud)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.top, -30)
                        .offset(x: 25)
                    Image(.cloud)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.top, -68)
                        .offset(x: -23)
                    Text("Frustrated")
                        .font(.custom("Lexend-Regular", size: 20))
                    Spacer()
                        .dynamicTypeSize(.accessibility1)                    //BUTTON
                    NavigationLink(destination: Breathing()){
                        Image(.redFlame)
                            .resizable()
                        .frame(width: 75, height: 125)}
                    Image(.cloud)
                        .resizable()
                        .frame(width: 75, height: 60)
                        .padding(.top, -32)
                        .offset(x: 35)
                    Image(.cloud)
                        .resizable()
                        .frame(width: 75, height: 60)
                        .padding(.top, -68)
                        .offset(x: -35)
                    Image(.upsideDownCloud)
                        .resizable()
                        .frame(width: 75, height: 60)
                        .offset(y: -55)
                    Text("Angry")
                        .font(.custom("Lexend-Regular", size: 20))
                        .padding(.top, -50)
                    
                } .dynamicTypeSize(.accessibility1)                .padding()
                
            }
        }
    }
}

#Preview {
    ContentView()
}
