import SwiftUI

// Inhale 4 seconds • Hold 7 seconds • Exhale 8 seconds

struct Breathing: View {

    @State private var scale: CGFloat = 1.0
    @State private var phase: BreathPhase = .idle
    @State private var flameGradient: [Color] = [
        Color.yellow, Color.orange.opacity(0.4)
    ]
    @State private var countdownTimer: Int = 7
    @State private var timerRunning = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Color.burntOrange.edgesIgnoringSafeArea(.all)
            
            Text(phaseText)
                .font(.custom("Lexend-Bold", size: 20))
                .minimumScaleFactor(0.5)
                .foregroundColor(phase == .hold ? .black : .burgundy)
                .shadow(color: (phase == .hold ? Color.black.opacity(0.25) : Color.white.opacity(0.8)),
                        radius: 0, x: 0, y: 0)
                .frame(width: 150, height: 150)
                .padding(.top, 100)
                .scaleEffect(scale)
                .animation(animationForPhase, value: scale)
          
            VStack(spacing: 16) {
                Text("Breathe with me...")
                    .font(.custom("Lexend-Bold", size: 30))
                    .padding(.top, 40)
                
                LinearGradient(colors: flameGradient, startPoint: .top, endPoint: .bottom)
                    .mask(
                        Image(.yellowFlame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                    )
                    .scaleEffect(scale)
                    .animation(animationForPhase, value: scale)
                    .animation(.easeInOut(duration: 1.0), value: flameGradient)
                
                Text(phaseLabel)
                    .font(.custom("Lexend-Medium", size: 20))
                    .foregroundColor(.black.opacity(0.9))
                
                if phase == .hold {
                    
                    Text("\(countdownTimer)")
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, -100)
                        .onReceive(timer) { _ in
                            
                    guard timerRunning else { return }
                            
                            if countdownTimer > 0 {
                                
                                countdownTimer -= 1
                                
                            } else {
                                timerRunning = false
                                startExhale()
                            }
                        }
                }
                
                Button(action: startSequence) {
                    
                    Text(phase == .idle ? "Start" : "Restart")
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
                .padding()
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
    
    private func startSequence() {
        
        phase = .idle
        withAnimation(.easeInOut(duration: 0.3)){
            scale = 1.0}
        
        flameGradient = [Color.yellow, Color.orange.opacity(0.4)]
        countdownTimer = 7
        timerRunning = false
        
        phase = .inhale
        
        withAnimation(.easeIn(duration: 4.0)) {
            
            scale = 2.0
            
        }
        
        withAnimation(.linear(duration: 4.0)) {
            flameGradient = [Color.orange.opacity(0.85), Color.orange]
        }
        
        Task {
            
            try? await Task.sleep(nanoseconds: 4_000_000_000)
            phase = .hold
            withAnimation(.easeInOut(duration: 1.0)) {
                flameGradient = [Color.red.opacity(0.4),Color.red.opacity(0.9), Color.red]
                
            }
            
            countdownTimer = 7
            timerRunning = true
        }
    }
    
    private func startExhale() {
        phase = .exhale
        
        withAnimation(.easeOut(duration: 8.0)) {
            scale = 1.0
        }
        
        withAnimation(.linear(duration: 8.0)) {
            flameGradient = [Color.yellow, Color.orange.opacity(0.35)]
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 8_000_000_000)
            phase = .idle
        }
    }
    
    private var animationForPhase: Animation {
        
        switch phase {
        case .inhale:
            return .easeIn(duration: 4.0)
        case .exhale:
            return .easeOut(duration: 8.0)
            
        default:
            return .default
        }
    }
    
    private var phaseLabel: String {
        
        switch phase {
        case .idle:   return "Ready"
        case .inhale: return ""
        case .hold:   return ""
        case .exhale: return ""
        }
    }
    
    private var phaseText: String {
        
        switch phase {
        case .inhale: return "Inhale…"
        case .hold:   return "Hold…"
        case .exhale: return "Exhale…"
        default: return ""
            
        }
    }
}


private enum BreathPhase {
    
    case idle, inhale, hold, exhale
    
}

#Preview {
    Breathing()
}
