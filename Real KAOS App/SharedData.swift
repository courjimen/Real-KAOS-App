import Foundation
import SwiftUI

struct StreakItem: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let category: String
}

class SharedData: ObservableObject {
    @Published var savedChallenges: [Kindness] = []
    @Published var completedChallenges: [Kindness] = []
    @Published var streakLog: [StreakItem] = []
    
    private func challengeLevel(for category: String) -> Int {
        switch category.lowercased() {
        case "simple": return 1
        case "affordable": return 2
        case "impactful": return 3
        default: return 0
        }
    }
    
    // MARK: Streak Calculation

    func calculateCurrentStreak() -> Int {
        let log = self.streakLog
        guard !log.isEmpty else { return 0 }
        
        let calendar = Calendar.current
        
        let uniqueDays: [Date] = log
            .map { calendar.startOfDay(for: $0.date) }
            .reduce(into: Set<Date>()) { $0.insert($1) }
            .sorted()
        
        guard !uniqueDays.isEmpty else { return 0 }
        
        let today = calendar.startOfDay(for: Date())
        var currentStreak = 0
        var previousDay: Date?
        
        
        let latestCompletedDay = uniqueDays.last!
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        if !calendar.isDate(latestCompletedDay, inSameDayAs: today) &&
           !calendar.isDate(latestCompletedDay, equalTo: yesterday, toGranularity: .day) {
            return 0
        }
        
        
        for day in uniqueDays.reversed() {
            if currentStreak == 0 {
                
                if calendar.isDate(day, inSameDayAs: today) ||
                   calendar.isDate(day, equalTo: yesterday, toGranularity: .day) {
                    currentStreak = 1
                    previousDay = day
                }
            } else if let prev = previousDay {
                let dayBefore = calendar.date(byAdding: .day, value: -1, to: prev)!
                
                if calendar.isDate(day, equalTo: dayBefore, toGranularity: .day) {
                    currentStreak += 1
                    previousDay = day
                } else {
                    
                    break
                }
            }
        }
        
        return currentStreak
    }
    
    // MARK: Completed/Saved Challenges
    
    func addChallenge(_ challenge: Kindness) {
        if savedChallenges.contains(where: { $0.id == challenge.id }) {
            return
        }
        savedChallenges.append(challenge)
    }
    
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
            logStreak(challenge: challengeToMove)
        }
    }
    
    // MARK: Counting Streaks (Completed Tasks)
    
    func logStreak(challenge: Kindness) {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let existingIndex = streakLog.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
            
            let existingLevel = challengeLevel(for: streakLog[existingIndex].category)
            let newLevel = challengeLevel(for: challenge.category)
            
            if newLevel > existingLevel {
                streakLog[existingIndex] = StreakItem(
                    date: today,
                    category: challenge.category)
            }
        } else {
            let newStreakItem = StreakItem(
                date: today,
                category: challenge.category
            )
            streakLog.append(newStreakItem)
        }
        
        streakLog.sort { $0.date < $1.date }
    }
}
