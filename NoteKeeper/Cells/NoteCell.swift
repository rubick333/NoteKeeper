//
//  NoteCell.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 25/04/24.
//

import UIKit

class NoteCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblNoteTitle: UILabel!
    @IBOutlet weak var lblNoteDescription: UILabel!
    @IBOutlet weak var lblCreatedOrModifiedDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(note:Note){
        self.lblNoteTitle.text = note.noteTitle
        self.lblNoteDescription.text = note.noteDescription
        
        let date:Date = (note.noteModificationDate != nil) ? (note.noteModificationDate)! : (note.noteCreationDate)!
        self.lblCreatedOrModifiedDate.text = "\(date.toString(dateFormat: "dd,MMM yyyy"))"
    }

}
