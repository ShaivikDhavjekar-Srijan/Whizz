//
//  DateFormatter+Ext.swift
//  Swiko
//
//  Created by Jitesh Acharya on 16/06/22.
//

import Foundation

extension DateFormatter {
    static let DATE_FORMAT: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}
