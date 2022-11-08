//
//  String+Ext.swift
//  Swiko
//
//  Created by Vishal.Grover on 08/06/22.
//

import Foundation

extension String{
    func isValidEmail( ) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    func isValidQuery() -> Bool {
        let queryRegEx = "^[A-Za-z]{1}[A-Za-z ]*$"
        let queryTest = NSPredicate(format:"SELF MATCHES %@", queryRegEx)
        let result = queryTest.evaluate(with: self)
        return result
    }
    
    func removeWhiteSpacesFromTheString() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func parseDob(inputFormat: String = DateConstants.DATE_FORMAT, outputFormat: String = DateConstants.TIMESTAMP_FORMAT) -> String {
        if(self.isEmpty){
            return ""
        }
        
        let currentDate = self
        var resultString = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        if let date = dateFormatter.date(from: currentDate) {
            dateFormatter.dateFormat = outputFormat
            resultString = dateFormatter.string(from: date)
        }
        
        return resultString
    }
    
    var toUrl: URL? {
        URL(string: self)
    }
}
