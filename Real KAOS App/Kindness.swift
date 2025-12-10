import Foundation

struct Kindness: Identifiable, Equatable {
    let id = UUID()
    let category: String
    let image: String
    let task: String
}

struct StreakItem: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let category: String
    let flameImageName: String
}
