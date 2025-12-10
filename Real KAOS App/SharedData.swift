import Foundation
import SwiftUI


class SharedData: ObservableObject {
    @Published var savedChallenges: [Kindness] = []
    
    func addChallenge(_ challenge: Kindness) {
        if savedChallenges.contains(where: { $0.id == challenge.id }) {
            return
        }
        savedChallenges.append(challenge)
    }
    
    @Published var completedChallenges: [Kindness] = []
    
    func addCompletedChallenge(_ challenge: Kindness) {
        if completedChallenges.contains(where: { $0.id == challenge.id }) {
            return
        }
        completedChallenges.append(challenge)
    }

    func moveChallengeToCompleted(challenge: Kindness) {
        if let index = savedChallenges.firstIndex(where: { $0.id == challenge.id }) {
            
            let challengeToMove = savedChallenges.remove(at: index)

            addCompletedChallenge(challengeToMove)
        }
    }
}
