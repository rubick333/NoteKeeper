//
//  DateHandler.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 25/04/24.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

