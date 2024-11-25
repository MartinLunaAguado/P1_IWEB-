//
//  QuizzesModel.swift
//  Quiz
//
//  Created by Santiago Pavón Gómez on 18/10/24.
//

import Foundation

/// Errores producidos en el modelo de los Quizzes
enum QuizzesModelError: LocalizedError {
    case internalError(msg: String)
    case corruptedDataError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .internalError(let msg):
            return "Error interno: \(msg)"
        case .corruptedDataError:
            return "Recibidos datos corruptos"
        case .unknownError:
            return "No chungo ha pasado"
       }
    }
}

//observable,útil para notificar cambios en la propiedad quizzes
@Observable class QuizzesModel {
    
    // Los datos
    private(set) var quizzes = [QuizItem]() //array de quizzes cargados, solo lectura desde fuera
    
    func load() {
        do {
            //Obtiene la URL del archivo "quizzes.json" en el paquete principal
            guard let jsonURL = Bundle.main.url(forResource: "quizzes", withExtension: "json") else {
                throw QuizzesModelError.internalError(msg: "No encuentro quizzes.json")
            }
            
            //carga los datos del archivo
            let data = try Data(contentsOf: jsonURL)
            
            // print("Quizzes ==>", String(data: data, encoding: String.Encoding.utf8) ?? "JSON incorrecto")
            
            //Decodifica los datos en un array 'QuizItem'
            guard let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data)  else {
                throw QuizzesModelError.corruptedDataError
            }
            
            //Asigna los quizzes cargados a la propiedad 'quizzes'
            self.quizzes = quizzes
            
            print("Quizzes cargados")
        } catch {
            print(error.localizedDescription)
        }
    }
}
