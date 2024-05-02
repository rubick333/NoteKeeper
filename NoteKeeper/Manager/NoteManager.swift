//
//  NoteManager.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 24/04/24.
//

import Foundation
import CoreData

struct NoteManager{
    
    private let noteDataRepository  = NoteDataRepository()
    
    func createNote(note:Note) -> Bool{
        return noteDataRepository.create(note: note)
    }
    
    func fetchNotes() -> [Note]? {
        return noteDataRepository.getAll()
    }
    
    func fetchNote(byIdentifier id:UUID) -> Note?{
        return noteDataRepository.get(byIdentifier: id)
    }
    
    func updateNote(note: Note) -> Bool{
        return noteDataRepository.update(note: note)
    }
    
    func deleteNote(note:Note) -> Bool{
        return noteDataRepository.delete(note: note)
    }
    
}
