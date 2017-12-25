//
//  CommanClass.swift
//  Mashy
//
//  Created by Mukesh Lokare on 20/12/17.
//  Copyright © 2017 amany. All rights reserved.
//

import Foundation

//MARK:- Comman Class to write methods
class Comman: NSObject {
    
    //MARK:- Method to return the english numbers
    func convertToEnglish(string:String) -> String{
        
        let NumberStr: String = string
        let Formatter: NumberFormatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale!
        let enString = Formatter.number(from: NumberStr)
        if enString != 0 {
            print("\(enString!)")
        }
        
        return (enString?.stringValue)!
    }
}

//MARK:- Extension to remove first character
extension String {
    var removePlus : String {
        mutating get {
            self.remove(at: startIndex)
            return self
        }
    }
}
