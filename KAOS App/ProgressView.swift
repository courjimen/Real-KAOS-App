import SwiftUI

struct SavedChallengeRow: View {
        @EnvironmentObject var sharedData: SharedData
        let challenge: Kindness
    
        @State private var isMoving = false
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(challenge.category.uppercased())
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.burgundy)
                    
                    Text(challenge.task)
                        .font(.custom("Lexend-Medium", size: 16))
                        .foregroundColor(.black)
                }
                .padding(.vertical, 8)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isMoving = true
                    }
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        sharedData.moveChallengeToCompleted(challenge: challenge)
                    }
                }) {
                    Text("Complete")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(isMoving ? .white : .primary) // Text color white if moving, primary (black) otherwise
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
    
                        .background(isMoving ? Color.green : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    struct ProgressView: View {
        @EnvironmentObject var sharedData: SharedData
        
        func deleteSavedItems(offsets: IndexSet) {
            sharedData.savedChallenges.remove(atOffsets: offsets)
        }
        
        func deleteCompletedItems(offsets: IndexSet) {
            sharedData.completedChallenges.remove(atOffsets: offsets)
        }
        
        var body: some View {
            NavigationView {
                TabView {
                    List {
                        if sharedData.savedChallenges.isEmpty {
                            Text("You haven't saved any challenges yet! Head back home to do a kind act.")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else {
                            ForEach(sharedData.savedChallenges) { challenge in
                                SavedChallengeRow(challenge: challenge)
                            }
                            .onDelete(perform: deleteSavedItems)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .tabItem {
                        Label("Saved", systemImage: "bookmark.fill")
                    }
                    
                    List {
                        if sharedData.completedChallenges.isEmpty {
                            Text("You haven't completed any challenges yet! Select one of your saved challenges to get started.")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else {
                            ForEach(sharedData.completedChallenges) { challenge in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(challenge.category.uppercased())
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.green)
                                    
                                    Text(challenge.task)
                                        .font(.custom("Lexend-Medium", size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                            .onDelete(perform: deleteCompletedItems)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .tabItem {
                        Label("Completed", systemImage: "checkmark.circle.fill")
                    }
                }
                .navigationTitle("Kindness Tracker")
            }
        }
    }

#Preview {
    let mockData = SharedData()
    mockData.savedChallenges.append(Kindness(category: "Simple", image: "yellowFlame", task: "Give a genuine, specific compliment to a stranger."))
    mockData.savedChallenges.append(Kindness(category: "Affordable", image: "orangeFlame", task: "Pay for someone else's coffee."))
    mockData.completedChallenges.append(Kindness(category: "Impactful", image: "redFlame", task: "Offer your seat on public transportation to someone in need."))
    
    return ProgressView()
        .environmentObject(mockData)
}
