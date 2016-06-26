//
//  RealmHelpers.swift
//  MakeSchoolNotes
//
//  Created by Sanjay noronha on 6/23/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static let realm = try! Realm()
    
    static func addNote(note:Note) {
        
        try! realm.write() {
            realm.add(note)
        }
    
    }
    
    static func deleteNote(note:Note) {
        
        try! realm.write() {
            realm.delete(note)
        }
        
    }
    
    static func updateNote(noteToBeUpdated:Note, newNote:Note) {
        
        
        try! realm.write() {
            noteToBeUpdated.title =   newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
        
    }
    
    static func retrieveNotes() -> Results<Note> {
        
        let realm = try! Realm()
        return  realm.objects(Note).sorted("modificationTime", ascending: false)
        
    }
    

    
}
