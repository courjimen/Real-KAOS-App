import SwiftUI

struct KindCard : View {
    let borderGradient = LinearGradient(
        colors: [Color(red: 0.98, green: 0.55, blue: 0.25), Color(red: 0.5, green: 0.0, blue: 0.13)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    var kindnessCard : Kindness
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .center) {
                //TOP FLAME
                Image(kindnessCard.image)
                    .resizable().scaledToFit().frame(width: 40, height: 40)
                    .padding()
                    .padding(.trailing, 275)
                
                Spacer()
                
                Text(kindnessCard.task)
                    .font(.custom("Lexend-Medium", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                //BOTTOM FLAME
                Image(kindnessCard.image)
                    .resizable().scaledToFit().frame(width: 40, height: 40)
                    .padding(.bottom, 10).padding(.leading, 275)
            }
            
            .frame(width: 325, height: 450)
            .background(Color.white)
            .cornerRadius(15)
            
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(borderGradient, lineWidth: 5)
            )
            .shadow(radius: 8)
        }
        .frame(width: 325, height: 450)
    }
}

#Preview {
    KindCard(kindnessCard: Kindness(
        category: "SIMPLE",
        image: "yellowFlame",
        task: "Take some time to spread some positive vibes. Leave a nice compliment or cook a meal for someone you care about."
    ))
}
