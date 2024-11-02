//
//  ContentView.swift
//  StickyNotesApp Watch App
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stickyNotes: [StickyNote] = [StickyNote]()
    @State private var text: String = ""
    var body: some View {
        VStack {
            TextField("Enter new note", text: $text)
            
            Button{
                guard !text.isEmpty else { return }
                
                let newNote = StickyNote(id: UUID(), text: text)
                stickyNotes.append(newNote)
                text = ""
            }label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 42, weight: .semibold))
            }
            .fixedSize()
            .foregroundColor(.accent)
        } //VSTACK
    }
}

#Preview {
    ContentView()
}
