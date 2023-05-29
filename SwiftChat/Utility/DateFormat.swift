//
//  DateFormate.swift
//  SwiftChat
//
//  Created by Rajaram on 27/05/23.
//

import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
}
