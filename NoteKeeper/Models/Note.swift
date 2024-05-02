//
//  Note.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 23/04/24.
//

import Foundation

struct Note
{
    var id: UUID
    var noteTitle: String?
    var noteDescription: String?
    var noteCategory: String?
    var noteCreationDate: Date?
    var noteModificationDate: Date?
    var noteAttachment: Data?
    var noteLock: Bool?
}
