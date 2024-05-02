//
//  UITextView+Extension.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 29/04/24.
//

import UIKit

extension UITextView{
    func addDoneButtonKeyboard(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self, action: #selector(resignFirstResponder))
        keyboardToolbar.items = [flexibleSpace, doneButton]
        self.inputAccessoryView = keyboardToolbar
    }
}
