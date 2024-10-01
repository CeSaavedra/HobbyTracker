/**
    HobbyData.swift
 
    Manages the list of hobbies. Initializes 10 preloaded hobbies
    and tracks changes made to the list of hobbies (Such as
    deleting and adding hobbies).
 */

import SwiftUI

// Observable Object Notifies views of any Changes
class HobbyData: ObservableObject {
    
    // Declares Published Property to Track Changes
    // Array of Hobby Objects
    @Published var hobbies: [Hobby] = [
        
        // Initializes 10 preloaded hobbies
        Hobby(name: "Reading", emoji: "📚"),
        Hobby(name: "Cooking", emoji: "🍳"),
        Hobby(name: "Running", emoji: "🏃‍♂️"),
        Hobby(name: "Gaming", emoji: "🎮"),
        Hobby(name: "Lifting", emoji: "🏋️"),
        Hobby(name: "Hiking", emoji: "🥾"),
        Hobby(name: "Swimming", emoji: "🏊"),
        Hobby(name: "Meditating", emoji: "🧘"),
        Hobby(name: "Sightseeing", emoji: "👀"),
        Hobby(name: "Bird Watching", emoji: "🐦"),
    ]
}
