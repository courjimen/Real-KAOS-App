import SwiftUI

enum Mood: String {
    case calm = "calm"
    case frustrated = "frustrated"
    case angry = "angry"
}

struct ContentView: View {
    @StateObject var sharedData = SharedData()
    var body: some View {
        NavigationStack {
            ZStack{
                Color.burntOrange.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image(.kaosLogo)
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    Text("How are you feeling?")
                        .font(.custom("Lexend-Bold", size: 20))
                    
                    //BUTTON
                    NavigationLink(destination: HomePage(selectedMood: .calm)){
                        Image(.yellowFlame)
                            .resizable()
                            .frame(width: 75, height: 125)
                    }
                    Text("Calm")
                        .font(.custom("Lexend-Medium", size: 20))
                    //BUTTON
                    NavigationLink(destination: Breathing(selectedMood: .frustrated)){
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
                        .font(.custom("Lexend-Medium", size: 20))
                    Spacer()
                    //BUTTON
                    NavigationLink(destination: Breathing(selectedMood: .angry)){
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
                        .font(.custom("Lexend-Medium", size: 20))
                        .padding(.top, -50)
                }
                .padding()
                
            }
        }
        .environmentObject(sharedData)
    }
}

#Preview {
    ContentView()
}
