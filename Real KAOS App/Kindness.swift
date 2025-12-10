//
//  Kindness.swift
//  Real KAOS App
//
//  Created by Courey Jimenez on 12/8/25.
//
import Foundation

struct Kindness: Identifiable, Equatable {
    let id = UUID()
    let category: String
    let image: String
    let task: String
}
