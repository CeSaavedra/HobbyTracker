/**
    ContentView.swift
 
    Defines HomeView, the main interface of the application.
    Utilizes NavigationView to provide a navigation bar on
    the top of the view which includes a title and navigation link.
    Underneath the NavigationView, the list of the user's hobbies
    is displayed and updated. The user also can delete a hobby  in
    this view by sliding on a hobby and pressing delete.
 */

import SwiftUI

// Defines HomeView
struct HomeView: View {
    // Declares StateObject to manage ObservableObject (HobbyData)
    @StateObject var hobbyData = HobbyData()

    var body: some View {
        // Creates Navigation Bar at top of View
        NavigationView {
            VStack {
                // Displays all Hobbies from HobbyData
                if hobbyData.hobbies.isEmpty {
                    Text("Add a Hobby using the '+' Button")
                        .foregroundColor(.gray)
                } else {
                    List {
                        // Iterates through each Hobby in HobbyData
                        ForEach(hobbyData.hobbies, id: \.id) { hobby in
                            HStack {
                                Text(hobby.emoji)
                                Text(hobby.name)
                            }
                        }
                        // Allows user to swipe on Hobby and Delete
                        .onDelete(perform: deleteHobby)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Creates Navigation Bar Title
                ToolbarItem(placement: .principal) {
                    Text("Hobby Tracker")
                        .font(.largeTitle) // Large Font Size
                }
                // Places plus icon at right side of Navigation Bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    // When Pressed, Directs user to the HobbyView
                    NavigationLink(destination: HobbyView(hobbyData: hobbyData)) {
                        Image(systemName: "plus") // Plus Icon
                            .foregroundColor(Color.red) // Sets color to red
                    }
                }
            }
        }
    }
    // Defines function to delete hobbies
    private func deleteHobby(at offsets: IndexSet) {
        // Removes hobby at specified offsets
        hobbyData.hobbies.remove(atOffsets: offsets)
    }
}

// Defines Hobby Struct
struct Hobby: Identifiable {
    let id = UUID() // Unique Hobby ID
    let name: String // Hobby Name
    let emoji: String // Hobby Emoji
}

// ONLY used for previewing in XCode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
