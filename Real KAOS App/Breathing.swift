//
//  Breathing.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/1/25.
//
import SwiftUI

struct Breathing: View {
    var body: some View {
        ZStack{
            Color.burntOrange.edgesIgnoringSafeArea(.all)
                .opacity(0.25)
            Text("Breathing")
        }
    }
}

#Preview {
    Breathing()
}
