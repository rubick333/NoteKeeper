//
//  AddNoteVC.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 25/04/24.
//

import UIKit

class AddNoteVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtFieldCategory: UITextField!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var btnAddEditNote: UIButton!
    
    //MARK: Variables
    lazy var noteManager:NoteManager = NoteManager()
    var editNote:Bool = false
    var note:Note?
    
    //MARK: UIViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEdit()
        setupTextViewDescription()
    }
    
    //MARK: UI Helper Methods
    func setUpEdit(){
        if(editNote){
            txtFieldTitle.text = note?.noteTitle
            txtFieldCategory.text = note?.noteCategory
            txtViewDescription.text = note?.noteDescription
            
            changeTxtViewDescription(makePlaceHolder: note?.noteDescription?.isEmpty ?? true)
            btnAddEditNote.setTitle(editNote ? "Edit Note" : "Add Note", for: .normal)
        }
    }
    
    private func setupTextViewDescription(){
        self.txtViewDescription.delegate = self
        self.txtViewDescription.addDoneButtonKeyboard()
        self.txtViewDescription.layer.cornerRadius = 8
        self.txtViewDescription.layer.borderWidth = 0.25
        self.txtViewDescription.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func changeTxtViewDescription(makePlaceHolder:Bool){
        if(makePlaceHolder){
            txtViewDescription.text = "Description"
            txtViewDescription.textColor = UIColor.lightGray
        }else{
            txtViewDescription.textColor = UIColor.black
        }
    }
    
    //MARK: Helper Methods
    private func add(note:Note){
        let result = noteManager.createNote(note: note)
        if(result){
            self.showToast(message: "Note added successfully", font: .systemFont(ofSize: 12))
            self.navigationController?.popViewController(animated: true)
        }else{
            self.showToast(message: "Unable to add the note", font: .systemFont(ofSize: 12))
        }
        
    }
    
    private func edit(note:Note){
        let result = noteManager.updateNote(note: note)
        if(result){
            self.showToast(message: "Note updated successfully", font: .systemFont(ofSize: 12))
            self.navigationController?.popViewController(animated: true)
        }else{
            self.showToast(message: "Unable to edit the note", font: .systemFont(ofSize: 12))
        }
    }
    
    //MARK: IBActions
    @IBAction func btnActionAddEditNote(_ sender: UIButton) {
        if(editNote){
            guard let id = note?.id else { return }
            let note = Note(id: id, noteTitle: txtFieldTitle.text, noteDescription: txtViewDescription.text, noteCategory: txtFieldCategory.text, noteCreationDate: note?.noteCreationDate, noteModificationDate: Date(), noteAttachment: nil, noteLock: false)
            edit(note: note)
        }else{
            let note = Note(id: UUID(), noteTitle: txtFieldTitle.text, noteDescription: txtViewDescription.text, noteCategory: txtFieldCategory.text, noteCreationDate: Date(), noteModificationDate: nil, noteAttachment: nil, noteLock: false)
            add(note: note)
        }
    }
    
}

extension AddNoteVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddNoteVC : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Description"){
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}
