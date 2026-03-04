# Eleven Note

Eleven Note is a simple note-taking app without all the fluff, written in **Swift 5** for iOS.

## Features

- **Create / Read / Update / Delete** notes
- **Search notes** — live full-text search across title and body
- **Sorted newest-first** — most recently edited notes float to the top
- **Relative timestamps** — shows "Today 3:42 PM", "Yesterday", or a short date
- **Live character count** — updates as you type in the note detail view
- **Tap-to-dismiss keyboard** — tap anywhere outside the text area to dismiss
- **Auto-save** — notes are persisted on every mutating operation and on every app lifecycle event (background / terminate)
- **"Untitled" fallback** — cells show "Untitled" when a note has no title
- Serialize and store notes in the sandbox documents folder

## What Changed (Enhanced by AgentR)

| Area | Change |
|---|---|
| **Swift syntax** | Updated entire codebase from Swift 1.x to **Swift 5** |
| **Singleton** | Replaced legacy class-var hack with `static let` |
| **Note model** | Added `lastModified` date; `shortDate` is now relative |
| **NoteStore** | Notes sorted newest-first; auto-save on every mutating operation; modern `FileManager` API |
| **Notes list** | Integrated `UISearchController` for live full-text search |
| **Note detail** | Character count label; tap-gesture keyboard dismiss; `UITextViewDelegate` |
| **Cell** | Falls back to "Untitled" when `title` is empty |
| **AppDelegate** | Saves on both `didEnterBackground` **and** `willTerminate` |

## About Eleven Fifty

Eleven Fifty is an immersive coding academy where you will build and ship three apps to the AppStore in just one week!

Learn more at [elevenfifty.com].

## Topics Explored

* Storyboards
* Model-View-Controller Pattern
* Singleton Pattern
* UIViewController
* UITableViewController / UITableViewDelegate / UITableViewDataSource
* UITableViewCell
* UILabel / UITextField / UITextView
* UIBarButtonItem / UINavigationController / UISearchController
* FileManager / NSKeyedArchiver / NSKeyedUnarchiver

## License

MIT

[elevenfifty.com]:http://elevenfifty.com
