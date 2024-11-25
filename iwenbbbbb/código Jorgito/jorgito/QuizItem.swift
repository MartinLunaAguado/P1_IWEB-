//
//  QuizItem.swift
//  Quiz
//
//  Created by Santiago Pavón Gómez on 18/10/24.
//

import Foundation

//Codable: la estructura se puede convertir a y desde un formato de datos como JSON
//Identifiable: proporciona una propiedad id para que los elementos puedan ser reconocidos de manera única

struct QuizItem: Codable, Identifiable { //protocolos codable y identifiable
    let id: Int
    let question: String
    let answer: String
    let author: Author? //la ? hace que sea opcional, puede ser nill
    let attachment: Attachment?
    let favourite: Bool
    
    struct Author: Codable {
        let isAdmin: Bool?
        let username: String?
        let profileName: String?
        let photo: Attachment?
    }
    
    struct Attachment: Codable {
        let filename: String?
        let mime: String?
        let url: URL?
    }
}
