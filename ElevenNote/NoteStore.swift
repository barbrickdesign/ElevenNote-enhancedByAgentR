//
//  NoteStore.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import Foundation

class NoteStore {
    // MARK: Singleton Pattern
    static let sharedNoteStore = NoteStore()

    // Private init to force usage of singleton
    private init() {
        load()
    }

    // Array to hold our notes
    private var notes: [Note] = []

    // CRUD - Create, Read, Update, Delete

    // Create
    @discardableResult
    func createNote(_ theNote: Note = Note()) -> Note {
        notes.append(theNote)
        save()
        return theNote
    }

    // Read – returns notes sorted newest-modified first
    func getNote(_ index: Int) -> Note {
        return sortedNotes[index]
    }

    var sortedNotes: [Note] {
        return notes.sorted { $0.lastModified > $1.lastModified }
    }

    // Search notes by title or body text (case-insensitive)
    func searchNotes(query: String) -> [Note] {
        guard !query.isEmpty else { return sortedNotes }
        let lower = query.lowercased()
        return sortedNotes.filter {
            $0.title.lowercased().contains(lower) || $0.text.lowercased().contains(lower)
        }
    }

    // Update
    func updateNote(theNote: Note) {
        theNote.lastModified = Date()
        save()
    }

    // Delete
    func deleteNote(_ index: Int) {
        let noteToDelete = sortedNotes[index]
        deleteNote(withNote: noteToDelete)
    }

    func deleteNote(withNote: Note) {
        notes.removeAll { $0 === withNote }
        save()
    }

    // Count
    func count() -> Int {
        return notes.count
    }


    // MARK: Persistence

    // 1: Find the file & directory we want to save to...
    func archiveFilePath() -> String {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent("NoteStore.plist").path
    }

    // 2: Do the save to disk.....
    func save() {
        NSKeyedArchiver.archiveRootObject(notes, toFile: archiveFilePath())
    }

    // 3: Do the reload from disk....
    func load() {
        let filePath = archiveFilePath()
        if FileManager.default.fileExists(atPath: filePath),
           let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Note] {
            notes = loaded
        } else {
            notes = []
        }
    }
}