//
//  NoteDetailViewController.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

    var theNote = Note()

    @IBOutlet weak var noteTitleLabel: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Update the screen with the contents of theNote
        noteTitleLabel.text = theNote.title
        noteTextView.text = theNote.text
        updateCharacterCount()

        // Observe text changes to update character count live
        noteTextView.delegate = self

        // Dismiss keyboard when tapping outside the text area
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        // Set the cursor in the note text area
        noteTextView.becomeFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Whenever we leave the screen, update our note model
        theNote.title = noteTitleLabel.text ?? ""
        theNote.text = noteTextView.text
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func updateCharacterCount() {
        let count = noteTextView.text.count
        characterCountLabel?.text = "\(count) character\(count == 1 ? "" : "s")"
    }
}

// MARK: - UITextViewDelegate
extension NoteDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
    }
}
