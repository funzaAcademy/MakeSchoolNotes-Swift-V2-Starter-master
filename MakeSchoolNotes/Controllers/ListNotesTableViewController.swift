//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    var notes = Results<Note>!(nil) {
        
        didSet {
            tableView.reloadData()
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    notes = RealmHelper.retrieveNotes()
    
  }
    
    // 1
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 3
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell

        let row = indexPath.row
        let note = notes[row]
        
        // 4
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        // 5
        return cell
    }
    
    
  
}


//show segues
extension ListNotesTableViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            
            if identifier == "displayNote" {
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                // 3
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                // 4
                displayNoteViewController.note = note
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
    
}

//unwind segues
extension ListNotesTableViewController {
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier {
            if identifier == "Cancel" {
                print("Cancel button tapped === 2 ")
            } else if identifier == "Save" {
                print("Save button tapped")
            }
        }
        
    }

}

//deleting notes
extension ListNotesTableViewController {
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 2
        if editingStyle == .Delete {
            // 3
            RealmHelper.deleteNote(notes[indexPath.row])
            notes = RealmHelper.retrieveNotes()

        }
    }
    
}




