//
//  Breathing.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/1/25.

import SwiftUI
//Inhale 4 seconds Hold for 7 Exhale for 8

struct Breathing: View {
    
    @State var scale = 1.0
    @State var animationAmount = 0.5
    @State var inhaleButton = false
    @State var holdBreath = false
    @State var exhaleButton = false
    @State var countdownTimer = 7
    @State var timerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        ZStack{
            Color.burntOrange.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Breathe with me...")
                    .font(.custom("Lexend-Bold", size: 20))
                    .padding()
                Button {
                    inhaleButton = true
                    self.scale = 2.0
                }
                label: {
                    Image(.inhale)
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .scaleEffect(scale)
                        .animation(.easeIn(duration: 4.0), value: scale)
                }
//                                    .overlay(Image(.redHeart)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 200, height: 200)
//                                        .offset(y: 112))
//                
//                
//                                VStack {
//                                    Button("Hold") {
//                                        timerRunning = true
//                                    }.foregroundColor(.white)
//                
//                                    Text("\(countdownTimer)")
//                
//                                        .foregroundStyle(Color.white)
//                                        .onReceive(timer) { _ in
//                                            if countdownTimer > 0 && timerRunning {
//                                                countdownTimer -= 1
//                                            } else {
//                                                timerRunning = false
//                                            }
//                
//                                        }
//                                        .font(.system(size: 40, weight: .bold))
//                
//                                    Button("Exhale") {
//                                        exhaleButton = true
//                                    }.foregroundColor(.yellow)
//                                }
//                                .offset(y: -50)
            }
        }
    }
    //ease in first
    //dispatch
    //ease out
}

#Preview {
    Breathing()
}
