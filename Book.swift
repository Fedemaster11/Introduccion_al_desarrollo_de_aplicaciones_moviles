//
//  Book.swift
//  BibliotecaPersonal
//
//  Created by Nick Rivera Guth on 28/2/26.
//

import Foundation

struct Book: Identifiable, Hashable, Codable {
    let id: UUID
    let title: String
    let author: String
    let year: Int
    var isFavorite: Bool
    
    init(id: UUID = UUID(), title: String, author: String, year: Int, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.author = author
        self.year = year
        self.isFavorite = isFavorite
    }
}
