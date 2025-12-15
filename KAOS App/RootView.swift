//
//  RootView.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/10/25.
//

import SwiftUI

let onboardingKey = "hasCompletedOnboarding"
//let debugOnboardingKey = "TESTING_hasCompletedOnboarding"
struct RootView: View {
    @AppStorage(onboardingKey) var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        if hasCompletedOnboarding {
            ContentView()
        } else {
            OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
    }
}
