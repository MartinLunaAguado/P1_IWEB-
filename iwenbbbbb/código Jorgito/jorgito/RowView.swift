//
//  RowView.swift
//  App_Quizzes
//
//  Created by jorge suarez on 13/11/24.
//

import SwiftUI

struct RowView: View {
    var quizItem: QuizItem
    @State private var userAnswer: String = ""
    @State private var resultMessage : String = ""
    
    var body: some View {
        VStack(spacing:20){
            if let url = quizItem.attachment?.url {
                AsyncImage(url: url) { image in
                        image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                        .shadow(color: Color.blue.opacity(0.3), radius: 10)
                    
                    } placeholder: {
                        ProgressView()
                        .frame(width: 150, height: 150)
                    }
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .foregroundColor(.gray)
                    .shadow(color: Color.gray.opacity(0.3), radius: 10)
            }
                Text(quizItem.question)
                               .font(.system(size: 22, weight: .bold, design: .rounded))
                               .multilineTextAlignment(.center)
                               .padding()
                               .background(Color.blue.opacity(0.1))
                               .cornerRadius(8)
                           
                TextField("Escribe tu respuesta...", text: $userAnswer)
                               .padding()
                               .background(Color(.systemGray6))
                               .cornerRadius(8)
                               .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                               .padding(.horizontal)
                       }
        Button(action: {
            if userAnswer.lowercased() == quizItem.answer.lowercased(){
                resultMessage = "¡Correcto!"
            }else{
                resultMessage = "¡Incorrecto!"
            }
        }){
            Text("Comprobar")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
        }
        Text(resultMessage)
                      .font(.title)
                      .foregroundColor(resultMessage == "¡Correcto!" ? .green : .red)
                      .padding(.top)
        
        Spacer()
                   }
               }


