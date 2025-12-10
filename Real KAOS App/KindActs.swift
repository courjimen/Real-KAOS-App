import SwiftUI

struct KindActs: View {
    
    enum ViewState: String {
        case none, simple, affordable, impactful
    }

    @State private var selectedCategory: ViewState = .none
    @State private var dragOffset: CGSize = .zero
    @State private var rotationAngle: Double = 0.0
   
    let simpleGradient = LinearGradient(
         colors: [Color(red: 0.97, green: 0.77, blue: 0.38), Color(red: 1.0, green: 0.73, blue: 0.03)],
         startPoint: .leading,
         endPoint: .trailing
     )
    let affordableGradient = LinearGradient(
        colors: [Color(red: 0.97, green: 0.77, blue: 0.38), Color(red: 0.89, green: 0.39, blue: 0.08)],
        startPoint: .leading,
        endPoint: .trailing
    )
    let impactfulGradient = LinearGradient(
        colors: [Color(.orange), Color(.red)],
        startPoint: .leading,
        endPoint: .trailing
    )
    
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

    private var currentDeck: [Kindness] {
        switch selectedCategory {
        case .simple: return simpleActs.shuffled()
        case .affordable: return affordableActs.shuffled()
        case .impactful: return impactfulActs.shuffled()
        case .none: return []
        }
    }

    private func handleCardSwipe() {
        dragOffset = .zero
        rotationAngle = 0.0
    }

    var body: some View {
        ZStack {
            Color.burntOrange.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                
                HStack{
                    Image(.yellowFlame).resizable().scaledToFit().frame(height: 50)
                    Image(.orangeFlame).resizable().scaledToFit().frame(height: 50)
                    Image(.redFlame).resizable().scaledToFit().frame(height: 50)
                }
                .padding()
                
                Text(selectedCategory == .none ? "Pick an act of kindness you'd like to pay forward!" : "Swipe through the **\(selectedCategory.rawValue.capitalized)** acts!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Lexend-Bold", size: 20))
                    .padding(10)
                
                
                if selectedCategory == .none {
                    // Category Selection Buttons
                    VStack(spacing: 20) {
                        CategoryButton(title: "Simple Acts", gradient: simpleGradient, description: "Quick, low-effort acts to build a habit of kindness.") {
                            selectedCategory = .simple
                        }
                        CategoryButton(title: "Affordable Acts", gradient: affordableGradient, description: "These involve a small financial exchange or tangible item to benefit a stranger.") {
                            selectedCategory = .affordable
                        }
                        CategoryButton(title: "Impactful Acts", gradient: impactfulGradient, description: "These involve more time or effort to create a big impact.") {
                            selectedCategory = .impactful
                        }
                    }
                    .padding(.top, 40)
                    
                } else {
                    // Swiping Card Stack
                    CardStackView(
                        deck: currentDeck,
                        dragOffset: $dragOffset,
                        rotationAngle: $rotationAngle,
                        onSwipe: handleCardSwipe
                    )
                    
                    // Back Button
                    Button {
                        selectedCategory = .none
                        dragOffset = .zero
                        rotationAngle = 0.0
                    } label: {
                        Text("Go Back to Categories")
                            .font(.custom("Lexend-Bold", size: 18))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.burgundy.opacity(0.15))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(Color.burgundy.opacity(0.35), lineWidth: 1)
                            )
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let gradient: LinearGradient
    let description: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 25)
                .fill(gradient)
                .frame(width: 350, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.burgundy, lineWidth: 2))
                .overlay(
                    VStack(alignment: .leading, spacing: 5) {
                        Text(title)
                            .font(.custom("Lexend-Bold", size: 18))
                            .foregroundColor(.black)
                            
                        Text(description)
                            .multilineTextAlignment(.leading)
                            .font(.custom("Lexend-Medium", size: 14))
                            .foregroundColor(.white)
                            .padding(.top, 5)
                    }
                .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                )
        }
    }
}

import SwiftUI

struct CardStackView: View {

    @State var deck: [Kindness]
    
    @Binding var dragOffset: CGSize
    @Binding var rotationAngle: Double
    let onSwipe: () -> Void
    
   
    private let swipeThreshold: CGFloat = 100
    private let cardWidth: CGFloat = 325
    private let cardAnimationDuration: Double = 0.4
    
    
    private let headerHeight: CGFloat = 60
    private let cardHeight: CGFloat = 450
    
   
    private let categoryGradient = LinearGradient(
        colors: [Color(red: 0.97, green: 0.77, blue: 0.38), Color(red: 0.89, green: 0.39, blue: 0.08)],
        startPoint: .leading,
        endPoint: .trailing
    )

    init(deck: [Kindness], dragOffset: Binding<CGSize>, rotationAngle: Binding<Double>, onSwipe: @escaping () -> Void) {
        _deck = State(initialValue: deck)
        _dragOffset = dragOffset
        _rotationAngle = rotationAngle
        self.onSwipe = onSwipe
    }

    
    private var topCardCategory: String? {
        deck.last?.category.uppercased()
    }
    
    var body: some View {
        VStack(spacing: 50) { 
            if let category = topCardCategory {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(categoryGradient)
                        .frame(width: cardWidth - 5, height: headerHeight) // Slightly narrower than the card
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3))
                    
                    Text(category)
                        .bold()
                        .font(.custom("Lexend-Bold", size: 24))
                        .foregroundColor(.white)
                }
                .padding(.bottom, -20)
                .zIndex(1)
            }
            
    
            ZStack {
                if deck.isEmpty {
                    Text("You've swiped all the acts in this category!")
                        .font(.title3)
                } else {
              
                    ForEach(deck.indices.reversed(), id: \.self) { index in
                        
                        let card = deck[index]
                        let isTopCard = index == deck.count - 1
                        
                        
                        KindCard(kindnessCard: card)
                            .zIndex(Double(index))
                            .scaleEffect(isTopCard ? 1.0 : 0.95)
                            
                          
                            .offset(isTopCard ? dragOffset : .zero)
                            .rotationEffect(.degrees(isTopCard ? rotationAngle : 0.0))
                            
                            .animation(.easeInOut(duration: 0.2), value: deck)
                            
                            .gesture(isTopCard ? dragGesture() : nil)
                    }
                }
            }
            
            .frame(height: cardHeight)
        }
    }
    
 
    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation
                rotationAngle = Double(value.translation.width / 20)
            }
            .onEnded { value in
                if abs(value.translation.width) > swipeThreshold {
                    let direction: CGFloat = value.translation.width > 0 ? 1 : -1
                    let offScreenX = direction * cardWidth * 2
                    
                    withAnimation(.easeOut(duration: cardAnimationDuration)) {
                        dragOffset = CGSize(width: offScreenX, height: value.translation.height)
                        rotationAngle = direction * 30
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + cardAnimationDuration) {
                        if !deck.isEmpty {
                            deck.removeLast()
                        }
                        onSwipe()
                    }
                } else {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        dragOffset = .zero
                        rotationAngle = 0.0
                    }
                }
            }
    }
}

#Preview {
    KindActs()
}
