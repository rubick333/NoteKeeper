//
//  CDNote+CoreDataProperties.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 24/04/24.
//
//

import Foundation
import CoreData


extension CDNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNote> {
        return NSFetchRequest<CDNote>(entityName: "CDNote")
    }

    @NSManaged public var noteTitle: String?
    @NSManaged public var noteDescription: String?
    @NSManaged public var noteLock: Bool
    @NSManaged public var noteCategory: String?
    @NSManaged public var noteCreationDate: Date?
    @NSManaged public var noteModificationDate: Date?
    @NSManaged public var noteAttachment: Data?
    @NSManaged public var id: UUID?

    func convertToNote() -> Note{
        return Note.init(id: self.id!, noteTitle: self.noteTitle, noteDescription: self.noteDescription, noteCategory: self.noteCategory, noteCreationDate: self.noteCreationDate, noteModificationDate: self.noteModificationDate, noteAttachment: self.noteAttachment, noteLock: self.noteLock)
    }
}

extension CDNote : Identifiable {

}
