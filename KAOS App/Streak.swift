import SwiftUI

struct Streak : View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        NavigationView {
                    VStack {
                        Text("Your Kindness Streak")
                            .font(.custom("Lexend-Bold", size: 30))
                            .foregroundColor(.burgundy)
                            .padding(.top, 20)

                        let currentStreak = calculateCurrentStreak(log: sharedData.streakLog)
                        Text("Current Streak: \(currentStreak) Day\(currentStreak == 1 ? "" : "s")")
                            .font(.custom("Lexend-Medium", size: 18))
                            .foregroundColor(.burgundy)
                            .padding(.bottom, 20)

                        // MARK: Calendar
                        ScrollView {
                            MonthView(sharedData: sharedData)
                        }
                    }
                    .background(Color.burntOrange.edgesIgnoringSafeArea(.all))
                    .navigationBarHidden(true)
                }
            }
            
            private func calculateCurrentStreak(log: [StreakItem]) -> Int {
                guard !log.isEmpty else { return 0 }
                
                let sortedLog = log.sorted { $0.date < $1.date }
                let calendar = Calendar.current
                var currentStreak = 0
                var maxStreak = 0
                var previousDate = calendar.startOfDay(for: Date())
                
               
                for item in sortedLog.reversed() {
                    let itemDay = calendar.startOfDay(for: item.date)
                    
                 
                    if calendar.isDate(itemDay, inSameDayAs: calendar.startOfDay(for: Date())) {
                        currentStreak = 1
                        previousDate = itemDay
                        maxStreak = max(maxStreak, currentStreak)
                        continue
                    }
                    
                 
                    let yesterday = calendar.date(byAdding: .day, value: -1, to: previousDate)!
                    
                    if calendar.isDate(itemDay, inSameDayAs: yesterday) {
                        currentStreak += 1
                        previousDate = itemDay
                    } else {
                    
                        break
                    }
                    maxStreak = max(maxStreak, currentStreak)
                }
                
                return maxStreak
            }
        }


        struct MonthView: View {
            @ObservedObject var sharedData: SharedData
            
            @State private var currentDate = Date()
            private let calendar = Calendar.current
            
            var body: some View {
                VStack {
                    HStack {
                        Button(action: { changeMonth(by: -1) }) { Image(systemName: "chevron.left") }
                        Spacer()
                        Text(monthYearString(from: currentDate))
                            .font(.custom("Lexend-Bold", size: 22))
                        Spacer()
                        Button(action: { changeMonth(by: 1) }) { Image(systemName: "chevron.right") }
                    }
                    .padding()
                    .foregroundColor(.burgundy)
                
                    HStack {
                        ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                            Text(day)
                                .frame(maxWidth: .infinity)
                                .font(.custom("Lexend-Medium", size: 14))
                                .foregroundColor(.burgundy.opacity(0.8))
                        }
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                        ForEach(daysInMonth(for: currentDate), id: \.self) { day in
                            DayCell(date: day, streakLog: sharedData.streakLog)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            
            private func daysInMonth(for date: Date) -> [Date?] {
                guard let monthInterval = calendar.dateInterval(of: .month, for: date) else { return [] }
                
                var days: [Date?] = []
                let startOfMonth = monthInterval.start
                
                
                let weekday = calendar.component(.weekday, from: startOfMonth)
                let firstDayOfWeek = calendar.firstWeekday
                let leadingSpaces = (weekday - firstDayOfWeek + 7) % 7
                
                for _ in 0..<leadingSpaces {
                    days.append(nil)
                }
            
                var currentDay = startOfMonth
                while currentDay < monthInterval.end {
                    days.append(currentDay)
                    guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDay) else { break }
                    currentDay = nextDay
                }
                
                return days
            }
            
            private func monthYearString(from date: Date) -> String {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM yyyy"
                return formatter.string(from: date)
            }
            
            private func changeMonth(by value: Int) {
                if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
                    currentDate = newDate
                }
            }
        }

        struct DayCell: View {
            let date: Date?
            let streakLog: [StreakItem]
        
            private var isToday: Bool {
                guard let date = date else { return false }
                return Calendar.current.isDateInToday(date)
            }
            
            private var streakItem: StreakItem? {
                guard let date = date else { return nil }
                return streakLog.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) })
            }
            
            var body: some View {
                ZStack {
                    if let date = date {
                        
                        Circle()
                            .stroke(isToday ? Color.burgundy : Color.clear, lineWidth: 2)
                            .frame(width: 50, height: 55)
                        
// MARK: Flame/Kindness Marker
                        if let item = streakItem {
                            Image(.redFlame)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 50)
                        }
                   
                        Text("\(Calendar.current.component(.day, from: date))")
                            .font(.custom("Lexend-Medium", size: 16))
                            .foregroundColor(isToday ? Color.burgundy : Color.burgundy.opacity(0.9))
                    } else {
                   
                        Color.clear
                            .frame(height: 35)
                    }
                }
            }
        }

// MARK: - Preview Mock Data

#Preview {
    let mockData = SharedData()
    let calendar = Calendar.current
    
    let today = calendar.startOfDay(for: Date())
    guard let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
          let dayBeforeYesterday = calendar.date(byAdding: .day, value: -2, to: today),
          let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: today),
          let fiveDaysAgo = calendar.date(byAdding: .day, value: -5, to: today) else {
        fatalError("Could not generate mock dates.")
    }
    
    mockData.streakLog = [
        
        StreakItem(date: fiveDaysAgo, category: "Simple"),
        StreakItem(date: threeDaysAgo, category: "Affordable"),
        StreakItem(date: dayBeforeYesterday, category: "Simple"),
        StreakItem(date: yesterday, category: "Impactful"),
        StreakItem(date: today, category: "Simple")
    ]
    return Streak()
        .environmentObject(mockData)
}
