//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {

  
    var note: Note?
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
  }
    
    override func viewWillAppear(animated: Bool) {
        
        print("viewWillAppear")
       
        if let note = note
        {
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
            
        }else {
            
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
        
        super.viewWillAppear(animated)
    }

}

extension DisplayNoteViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
         
            if identifier == "Cancel" {
                print("Cancel button tapped === 1")
            } else if identifier == "Save" {
                print("Save button tapped")
                
                let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
                
                if let note = note {
                
                    // This is a modified note
                    let newNote = Note()
                    newNote.title = noteTitleTextField.text ?? ""
                    newNote.content = noteContentTextView.text ?? ""
                    
                    RealmHelper.updateNote(note, newNote: newNote)
                    
                    
                }
                else {
                    
                    let note = Note()
                    // 2
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text ?? ""
                    // 3
                    note.modificationTime = NSDate()
                    
                    //Lets now save the note in the destination view controller
                    
                    // 2
                    RealmHelper.addNote(note)
                }
                
                listNotesTableViewController.notes = RealmHelper.retrieveNotes()
            }
        }
    }
    
    

}