//
//  Progress.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/9/25.
//
import SwiftUI

struct ProgressView: View {
    // Access the shared data model
    @EnvironmentObject var sharedData: SharedData

    var body: some View {
        NavigationView {
            List {
                if sharedData.savedChallenges.isEmpty {
                    Text("You haven't saved any challenges yet! Head back to the Acts tab to choose one.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ForEach(sharedData.savedChallenges) { challenge in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(challenge.category.uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.burgundy) // Assuming Color.burgundy is defined
                            
                            Text(challenge.task)
                                .font(.custom("Lexend-Medium", size: 16))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .navigationTitle("My Saved Acts")
        }
    }
}
#Preview {
    ProgressView()
}
