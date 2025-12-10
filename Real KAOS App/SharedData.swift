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
    
    @Published var streakLog: [StreakItem] = []
    
    func logStreak(challenge: Kindness) {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let existingIndex = streakLog.firstIndex(where: {Calendar.current.isDate($0.date, inSameDayAs: today)}) {
            
            let existingLevel = challengeLevel(for: streakLog[existingIndex].category)
            let newLevel = challengeLevel(for: challenge.category)
            
            if newLevel > existingLevel {
                streakLog[existingIndex] = StreakItem(date: today, category: challenge.category, flameImageName: challenge.image)
            }
        } else {
            let newStreakItem = StreakItem(date: today, category: challenge.category, flameImageName: challenge.image)
            streakLog.append(newStreakItem)
        }
        streakLog.sort {$0.date < $1.date }
        print("Streak Log: \(streakLog.map { "\($0.category) on \($0.date)" })")
    }
    
    func challengeLevel(for category: String) -> Int {
        switch category.lowercased() {
        case "simple": return 1
        case "affordable": return 2
        case "impactful": return 3
        default : return 0
        }
    }
}
