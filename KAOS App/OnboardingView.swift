//
//  OnboardingView.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/10/25.
//

import SwiftUI
//let onboardingKey = "hasCompletedOnboarding"

let borderGradient = LinearGradient(
    colors: [Color(red: 0.98, green: 0.55, blue: 0.25), Color(red: 0.5, green: 0.0, blue: 0.13)],
    startPoint: .top,
    endPoint: .bottom
)

enum OnboardingPage: Int, CaseIterable {
    case deepBreaths
    case kindTasks
    case kindStreak
    
    var title: String {
        switch self {
        case .deepBreaths:
            return "Deep Breathing Exercises"
        case .kindTasks:
            return "Real-Life Scenarios"
        case .kindStreak:
            return "Build Kinder Habits"
        }
    }
    
    var description: String {
        switch self {
        case .deepBreaths:
            return "Learn how to de-escalate and emotionally regulate in stressful situations."
        case .kindTasks:
            return "Explore opportunities to practice kindness in real-world situations."
        case .kindStreak:
            return "Track how often you're making a positive impact by building a daily streak of kindness."
        }
    }
}
struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State var currentPage = 0
    @State var isAnimating = false
    @State var deliveryOffset = false
    @State var trackingProgress: CGFloat = 0.0
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring(), value: currentPage)
            
            HStack(spacing: 12){
                ForEach(0..<OnboardingPage.allCases.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.burgundy : Color.gray.opacity(0.5))
                        .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                        .animation(.spring(), value: currentPage)
                }
            }
            .padding(.bottom, 20)
            
            Button {
                withAnimation(.spring()) {
                    if currentPage < OnboardingPage.allCases.count - 1 {
                        currentPage += 1
                        isAnimating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            isAnimating = true
                        })
                    } else {
                        hasCompletedOnboarding = true                    }
                }
            } label: {
                Text(currentPage < OnboardingPage.allCases.count - 1 ? "Next" : "Get Started")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color.burgundy,
                            Color.burgundy.opacity(0.8)
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.burgundy.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                withAnimation {
                    isAnimating = true
                }
            })
        }
    }
    
    var flameImages: some View {
        ZStack {
            Image(.redFlame)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
        }
    }
    var cardImages: some View {
        ZStack {
            Image(.challenge)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
                .padding(.top, -23)
        }
    }
    
    var calendarImages: some View {
        ZStack {
            Image(.streak)
                .resizable()
                .scaledToFit()
                .frame(height: 225)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(borderGradient, lineWidth: 4)
                )
                .shadow(radius: 8)
        }
    }
    
    @ViewBuilder
    func getPageView(for page: OnboardingPage) -> some View {
        VStack(spacing: 30) {
            //MARK: Images
            ZStack {
                switch page {
                case .deepBreaths:
                    flameImages
                case .kindTasks:
                    cardImages
                case .kindStreak:
                    calendarImages
                }
            }
            
            //MARK: Content
            VStack(spacing: 20) {
                Text(page.title)
                    .font(.custom("Lexend-ExtraBold", size: 25))
                    .foregroundColor(.burgundy)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
                
                Text(page.description)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
            }
        }
        .padding(.top, 50)
    }
}


#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
