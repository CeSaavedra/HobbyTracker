/**
    HobbyView.swift
 
    User navigates to this view when plus sign is used in HomeView.
    Displays input text field, a selector wheel with 20 emojis, and a
    Submit button. The submit button is disabled until the input is
    between 3-16 chracters. If a duplicate hobby is attempted, an
    alert is displayed. The coloration of the UI is meant to resemble
    what would be a "Dark Mode".
 */


import SwiftUI

struct HobbyView: View {
    @ObservedObject var hobbyData: HobbyData
    @State private var hobbyName: String = ""
    @State private var selectedEmoji: String = ""
    // Defines 20 emojis for the selector wheel
    @State private var emojis = ["🏀", "🏓", "✈️", "🎨", "🎧", "🎹", "📝", "🧶", "💃", "🤼", "⚽️", "🏈", "🎤", "⚾️", "🎬", "🎲", "🎯", "🎳", "🏎️", "🏂"]
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            
            // Sets the background color of UI
            Color(red: 25/255, green: 25/255, blue: 25/255)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                }

            VStack {
                // Declares the Text Field
                TextField("Enter hobby name", text: $hobbyName)
                    .padding()
                    .frame(height: 60) // Increased Text Field Height
                    .background(Color.white) // Colors Text Field Background White
                    .cornerRadius(5) // Rounds corners of Text Field
                    .padding()
                
                // Declares Emoji Picker
                Picker("Select an emoji", selection: $selectedEmoji) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji).tag(emoji)
                    }
                }
                // Styles Picker to be in Wheel Form
                .pickerStyle(WheelPickerStyle())

                Button(action: {
                    // If selector does not receive input,
                    // the first emoji is assumed
                    if selectedEmoji.isEmpty {
                        selectedEmoji = "🏀"
                    }
                    
                    // Creates alert if duplicate Hobby attempted
                    if hobbyData.hobbies.contains(where: { $0.name.lowercased() == hobbyName.lowercased() }) {
                        alertMessage = "Hobby already exists."
                        showAlert = true
                        
                    } else {
                        
                        // Hobby is added to HobbyData
                        let newHobby = Hobby(name: hobbyName, emoji: selectedEmoji)
                        hobbyData.hobbies.append(newHobby)
                        hobbyName = ""
                        selectedEmoji = ""
                    }
                }) {
                    // Defines Submit Button
                    Text("Submit")
                        .font(.system(size: 20))
                        .padding()
                        // Button appears gray if name is not between 3-16 characters
                        .background(hobbyName.count >= 3 && hobbyName.count <= 16 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                // Disables button if name is not between 3-16 characters
                .disabled(hobbyName.count < 3 || hobbyName.count > 16)
                // Displays Alert
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Adds Title to Navigation Bar when the user navigates to HobbyView
            ToolbarItem(placement: .principal) {
                Text("Add Hobby")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

// Allows keyboard disabiling capabilities
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// ONLY used for previewing in XCode
struct HobbyView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyView(hobbyData: HobbyData())
    }
}
