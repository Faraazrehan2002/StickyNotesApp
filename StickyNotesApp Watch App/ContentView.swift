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
    
    // MARK: FUNCTIONS
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func saveStickyNotes() {
        let fileURL = getDocumentDirectory().appendingPathComponent("stickyNotes.json")
        
        do {
            let data = try JSONEncoder().encode(stickyNotes)
            try data.write(to: fileURL)
        } catch {
            print("Error saving sticky notes: \(error)")
        }
    }
    
    func loadStickyNotes() {
        DispatchQueue.main.async{
            
            do {
                
                let fileURL = getDocumentDirectory().appendingPathComponent("stickyNotes.json")
                
                let data = try Data(contentsOf: fileURL)
                
                stickyNotes = try JSONDecoder().decode([StickyNote].self, from: data)
                
            } catch {
                
            }
            
        }
        
    }
    
    func deleteStickyNotes(at offsets: IndexSet){
        
        withAnimation{
            stickyNotes.remove(atOffsets: offsets)
            saveStickyNotes()
        }
        
    }
    
    
    // MARK: MAIN BODY
    var body: some View {
        
        NavigationStack{
            
            VStack {
                
                HStack{
                    
                    TextField("Enter new note", text: $text)
                    
                    Button{
                        guard !text.isEmpty else { return }
                        
                        let newNote = StickyNote(id: UUID(), text: text)
                        
                        stickyNotes.append(newNote)
                        
                        text = ""
                        
                        saveStickyNotes()
                    }label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .foregroundColor(.accent)
                    
                };List{
                    
                    ForEach(0..<stickyNotes.count, id: \.self){
                        i in HStack{
                            Capsule()
                                .frame(width: 4)
                            
                            Text(stickyNotes[i].text)
                                .lineLimit(1)
                                .padding(.leading, 5)
                                
                                
                        }
                    }.onDelete(perform: deleteStickyNotes)
                    
                }.navigationTitle("Sticky Notes")//HSTACK
                    .onAppear(
                        perform: {
                            loadStickyNotes()
                        }
                    )
                
        
            } //VSTACK
            
        }//NAVIGATIONSTACK
        
        
    }
}

#Preview {
    ContentView()
}
