//
//  KindActs.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/5/25.
//

import SwiftUI

struct KindActs: View {
    @GestureState var offset = CGSize.zero
    @State var simpleActs: [Kindness] = [
        Kindness(category: "Simple", image: "yellowFlame", task: "Give a genuine, specific compliment to a stranger or an acquanintance. Focus on something they chose (e.g., a project they worked on) not just an inherent trait." ),
        Kindness(category: "Simple", image: "yellowFlame", task: "Let a merging car into your lane with a wave or smile."),
        Kindness(category: "Simple", image: "yellowFlame", task: "Share your umbrella with a stranger on a rainy day."),
        Kindness(category: "Simple", image: "yellowFlame", task: "Leave a positive sticky note with an uplifting message in a public restroom or on a library book."),
        Kindness(category: "Simple", image: "yellowFlame", task: "Compliment a coworker to their boss (no snitching)."),
        Kindness(category: "Simple", image: "yellowFlame", task: "Leave a positive note on a stranger's car."),
        Kindness(category: "Simple", image: "yellowFlame", task: "Hold the door or the elevator for others, especially if they have their hands full." )
    ]
     
    @State var affordableActs: [Kindness] = [
        Kindness(category: "Affordable", image: "orangeFlame", task: "Pay for someone else's order in a drive-thru or their coffee in line and drive away."),
        Kindness(category: "Affordable", image: "orangeFlame", task: "Give an extra-large tip to a server or barista who provides great service."),
        Kindness(category: "Affordable", image: "orangeFlame", task: "Leave a big tip for your server and tell them they did a phenomenal job." ),
        Kindness(category: "Affordable", image: "orangeFlame", task: "Let someone go ahead of you in a grocery store or bank line."),
        Kindness(category: "Affordable", image: "orangeFlame", task: "Pick up a piece of litter and dispose of it properly." ),
        Kindness(category: "Affordable", image: "orangeFlame", task: "Put more time on an expired parking meter." ),
        Kindness(category: "Affordable", image: "orangeFlame", task: "Leave a bouquet of flowers on a colleague's desk and tell them they are loved.")
    ]
    
    @State var impactfulActs: [Kindness] = [
        Kindness(category: "Impactful", image: "redFlame", task: "Offer your seat on public transportation to someone who looks exhausted or needs it more and give them a couple of dollars." ),
        Kindness(category: "Impactful", image: "redFlame", task: "Offer to help a neighbor with a chore, such as mowing their lawn, cutting their hedge, or shoveling their driveway." ),
        Kindness(category: "Impactful", image: "redFlame", task: "Bring a box of donuts or other treats to the office to share and tell them you appreciate them." ),
        Kindness(category: "Impactful", image: "redFlame", task: "Offer to help a neighbor with their grocery shopping and walk their dog." ),
        Kindness(category: "Impactful", image: "redFlame", task: "Hide a small amount of money (like a few dollars or coins) on a store shelf or at a vending machine for the next person to find." ),
        Kindness(category: "Impactful", image: "redFlame", task: "G" ),
    ]
    var body: some View {
    
        VStack(alignment: .center){
            ZStack{
                Color.burntOrange.edgesIgnoringSafeArea(.all)
                    .gesture(
                        DragGesture()
                            .updating($offset) {
                                value, state, _ in state = value.translation
                            })
                
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
                        .padding(10)
                    
                    NavigationLink {
                        KindCard(kindnessCard: simpleActs.randomElement()!)
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 350, height: 100)
                            //.gradient(Colors: [.yellow, .orange])
                            .foregroundColor(Color.orange)
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.burgundy, lineWidth: 2))
                            .overlay(Text("Simple Acts")
                                .font(.custom("Lexend-Bold", size: 18))
                                .foregroundStyle(.black)
                                .padding(.trailing, 190)
                                .padding(.top, -30))
                        
                            .overlay(Text("These are quick, low-effort acts that can be done daily to build a habit of kindness.")
                                .multilineTextAlignment(.leading)
                                .font(.custom("Lexend-Medium", size: 14))
                                .foregroundStyle(Color.white)
                                .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 30)))
                    }
                    
                    NavigationLink {
                        KindCard(kindnessCard: affordableActs.randomElement()!)
                           
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 350, height: 100)
                            .foregroundColor(Color.orange)
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.burgundy, lineWidth: 2))
                            .overlay(Text("Affordable Acts")
                                .font(.custom("Lexend-Bold", size: 18))
                                .foregroundStyle(.black)
                                .padding(.trailing, 155)
                                .padding(.top, -30))
                            .overlay(Text("These involve a small financial exchange or tangible item to benefit a stranger.")
                                .multilineTextAlignment(.leading)
                                .font(.custom("Lexend-Medium", size: 14))
                                .foregroundStyle(Color.white)
                                .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 30)))
                    }
                    .padding()
                    
                    NavigationLink {
                        KindCard(kindnessCard: impactfulActs.randomElement()!)
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 350, height: 100)
                            .foregroundColor(Color.orange)
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.burgundy, lineWidth: 2))
                            .overlay(Text("Impactful Acts")
                                .font(.custom("Lexend-Bold", size: 18))
                                .foregroundStyle(.black)
                                .padding(.trailing, 160)
                                .padding(.top, -30))
                        
                            .overlay(Text("These involve a small financial exchange or tangible item to benefit a stranger.")
                                .multilineTextAlignment(.leading)
                                .font(.custom("Lexend-Medium", size: 14))
                                .foregroundStyle(Color.white)
                                .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 30)))
                    }
                }
                .padding()
                
            }
        }
    }
}


#Preview {
    KindActs()
}
