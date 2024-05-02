//
//  NoteRepository.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 23/04/24.
//

import Foundation
import CoreData

protocol NoteRepositoryProtocol{
    func create(note: Note) -> Bool
    func getAll() -> [Note]?
    func get(byIdentifier id: UUID) -> Note?
    func update(note: Note) -> Bool
    func delete(note: Note) -> Bool
}

struct NoteDataRepository : NoteRepositoryProtocol{
    
    func create(note: Note) -> Bool {
        let cdNote = CDNote(context: PersistentStorage.shared.context)
        
        cdNote.id = note.id
        cdNote.noteTitle = note.noteTitle
        cdNote.noteDescription = note.noteDescription
        cdNote.noteCategory = note.noteCategory
        cdNote.noteCreationDate = note.noteCreationDate
        cdNote.noteModificationDate = note.noteModificationDate
        cdNote.noteAttachment = note.noteAttachment
        cdNote.noteLock = note.noteLock ?? false
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func getAll() -> [Note]? {
        let arrManagedObject = PersistentStorage.shared.fetchManagedObject(managedObject: CDNote.self)
        var arrNote:[Note] = []
        arrManagedObject?.forEach({ cdNote in
            arrNote.append(cdNote.convertToNote())
        })
        return arrNote
    }
    
    func get(byIdentifier id: UUID) -> Note? {
        guard let result = getCDNote(byIdentifier: id) else { return nil }
        return result.convertToNote()
    }
    
    func update(note: Note) -> Bool {
        guard let cdNote = getCDNote(byIdentifier: note.id) else { return false }
        
        cdNote.noteTitle = note.noteTitle
        cdNote.noteDescription = note.noteDescription
        cdNote.noteCategory = note.noteCategory
        cdNote.noteAttachment = note.noteAttachment
        cdNote.noteCreationDate = note.noteCreationDate
        cdNote.noteModificationDate = note.noteModificationDate
        cdNote.noteLock = note.noteLock ?? false
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(note: Note) -> Bool {
        guard let cdNote = getCDNote(byIdentifier: note.id) else { return false }
        PersistentStorage.shared.context.delete(cdNote)
        PersistentStorage.shared.saveContext()
        return true
    }

    //MARK: Helper Methods
    private func getCDNote(byIdentifier id: UUID) -> CDNote?{
        let fetchRequest = CDNote.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            guard let result = try PersistentStorage.shared.context.fetch(fetchRequest).first else { return nil }
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func getDatabaseDirectory(){
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path[0])
    }
    
}
