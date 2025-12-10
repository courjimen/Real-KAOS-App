import SwiftUI

struct KindCard : View {
    private let borderGradient = LinearGradient(
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
        task: "Give a genuine, specific compliment to a stranger or an acquaintance. Focus on something they chose (e.g., their shirt, a project they worked on), not just an inherent trait."
    ))
}
