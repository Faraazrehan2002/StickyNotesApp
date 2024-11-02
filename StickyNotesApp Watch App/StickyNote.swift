//
//  StickyNote.swift
//  StickyNotesApp Watch App
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/1/24.
//

import Foundation

struct StickyNote: Codable, Identifiable {
    let id: UUID
    let text: String
}
