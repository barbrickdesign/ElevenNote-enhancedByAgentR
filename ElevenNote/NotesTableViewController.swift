//
//  NotesTableViewController.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    // Search controller for filtering notes
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearching: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    private var filteredNotes: [Note] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Leverage the built-in TableViewController Edit button
        navigationItem.leftBarButtonItem = editButtonItem

        // Set up the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Notes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Ensure we are not in edit mode and the list is fresh
        isEditing = false
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Here we pass the note they tapped on between the view controllers
        if segue.identifier == "NoteDetailPush" {
            let noteDetail = segue.destination as! NoteDetailViewController
            let theCell = sender as! NoteDetailTableViewCell
            noteDetail.theNote = theCell.theNote
        }
    }

    @IBAction func saveFromNoteDetail(segue: UIStoryboardSegue) {
        // We come here from an exit segue when they hit save on the detail screen
        let noteDetail = segue.source as! NoteDetailViewController

        // If there is a row selected, it was an edit; otherwise create new
        if tableView.indexPathForSelectedRow != nil {
            NoteStore.sharedNoteStore.updateNote(theNote: noteDetail.theNote)
        } else {
            NoteStore.sharedNoteStore.createNote(noteDetail.theNote)
        }

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredNotes.count : NoteStore.sharedNoteStore.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteDetailTableViewCell", for: indexPath) as! NoteDetailTableViewCell
        let theNote = isSearching ? filteredNotes[indexPath.row] : NoteStore.sharedNoteStore.getNote(indexPath.row)
        cell.setupCell(theNote)
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if isSearching {
                let note = filteredNotes.remove(at: indexPath.row)
                NoteStore.sharedNoteStore.deleteNote(withNote: note)
            } else {
                NoteStore.sharedNoteStore.deleteNote(indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - UISearchResultsUpdating
extension NotesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredNotes = NoteStore.sharedNoteStore.searchNotes(query: searchController.searchBar.text ?? "")
        tableView.reloadData()
    }
}
