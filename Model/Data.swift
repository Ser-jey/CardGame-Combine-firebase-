//
//  Data.swift
//  ReadDataFromDB (iOS)
//
//  Created by Сергей Кривошеев on 04.03.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Data: Identifiable, Codable {
    //var id: String = UUID().uuidString
    @DocumentID var id: String?
    var question: String
    var answer: String
    var passed: Bool = false
}
