//
//  Note.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import Foundation

class Note: NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = Date() // Defaults to current date / time
    var lastModified = Date() // Tracks the most recent edit

    // Computed property to return the date as a human-readable string:
    //   - Today:     "h:mm a"   (e.g. "3:42 PM")
    //   - Yesterday: "Yesterday"
    //   - Older:     "MM/dd/yy" (e.g. "01/15/24")
    var shortDate: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(lastModified) {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: lastModified)
        } else if calendar.isDateInYesterday(lastModified) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            return formatter.string(from: lastModified)
        }
    }

    override init() {
        super.init()
    }

    // 1: Encode ourselves...
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(lastModified, forKey: "lastModified")
    }

    // 2: Decode ourselves on init
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        self.text  = aDecoder.decodeObject(forKey: "text") as? String ?? ""
        self.date  = aDecoder.decodeObject(forKey: "date") as? Date ?? Date()
        self.lastModified = aDecoder.decodeObject(forKey: "lastModified") as? Date ?? self.date
    }
}