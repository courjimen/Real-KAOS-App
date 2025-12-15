import Foundation

struct Kindness: Identifiable, Equatable {
    let id = UUID()
    let category: String
    let image: String
    let task: String
}
