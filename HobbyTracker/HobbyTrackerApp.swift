/**
    HobbyTrackerApp.swift
 
    Main entry point of the Hobby Tracker application. Ensures the
    HomeView is displayed on startup.
 */

import SwiftUI

@main // Establishes Main Entry Point

struct HobbyTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView() // Initial View
        }
    }
}
