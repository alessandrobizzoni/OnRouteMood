//
//  ORMBugReport.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 16/5/25.
//

import Foundation

struct ORMBugReport: Codable, Identifiable {
    var id = UUID()
    let firstName: String
    let surname: String
    let email: String
    let phone: String
    let date: Date
    let description: String
}
