import SwiftUI

struct HomePage: View {
    let selectedMood: Mood
    @EnvironmentObject var sharedData: SharedData
    
    @State var heartButton = false
    @State var delayNav = false
    
    var streakCount: Int {
        sharedData.calculateCurrentStreak()
    }
    
    var body: some View {
        ZStack { Color.burntOrange.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center){
                            HStack{
                                Image(.kaosLogo)
                                    .padding(.leading, 100)
                                NavigationLink(destination: Streak())
                                { Image(.yellowFlame)
                                    .resizable()
                                    .frame(width: 50, height: 75)
                                    .padding(.leading, 50)
                                    
                                    // ⭐️ MODIFIED CODE HERE: Use the streakCount variable
                                    .overlay(Text("\(streakCount)")
                                        .foregroundStyle(Color.burgundy)
                                        .font(Font.custom("Lexend-Bold", size: 18))
                                        .padding(.leading, 50)
                                        .padding(.top, 45))
                                }
                            }
                            .padding(.bottom, 50)
                Button {
                    heartButton.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        delayNav = true
                    })
                    
                } label: {
                    Image(.yellowFlame)
                        .resizable()
                        .frame(width: 325, height: 435)
                        .background(
                            NavigationLink(destination: KindActs(),isActive: $delayNav) {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 215, height: 165)
                                    .padding(.top, 120)
                                    .offset(x: 6, y: 75)
                                    .foregroundStyle(heartButton ? Color.burgundy : Color.burntOrange)
                            }
                        )
                }
                .onAppear {
                    delayNav = false
                    heartButton = false
                }
                Text("Do A Kind Act")
                    .font(Font.custom("Lexend-Bold", size: 25))
                    .foregroundStyle(heartButton ? Color.white : Color.burgundy)
                    .offset(x: 5, y: -115)
                
                Text("You are feeling \(selectedMood.rawValue) right now")
                
                HStack {
                    NavigationLink(destination: ProgressView()) {
                        Image(.cloud)
                            .overlay(
                                Text("Kindness Tracker")
                                    .foregroundStyle(Color.burgundy)
                                    .offset(y: 5)
                            )}
                    
                    NavigationLink(destination: Breathing(selectedMood: selectedMood)){
                        Image(.cloud)
                            .overlay(
                                Text("Stress Reduction")
                                    .foregroundStyle(Color.burgundy)
                                    .offset(y: 4)
                            )}
                }
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    HomePage(selectedMood: .calm)
        .environmentObject(SharedData())
}
