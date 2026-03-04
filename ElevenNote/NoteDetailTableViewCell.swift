//
//  NoteTableViewCell.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NoteDetailTableViewCell: UITableViewCell {

    // The note currently being shown
    weak var theNote: Note!

    // Interface builder outlets
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!

    // Insert note contents into the cell
    func setupCell(_ theNote: Note) {
        self.theNote = theNote
        noteTitleLabel.text = theNote.title.isEmpty ? "Untitled" : theNote.title
        noteTextLabel.text = theNote.text
        noteDateLabel.text = theNote.shortDate
    }
}
