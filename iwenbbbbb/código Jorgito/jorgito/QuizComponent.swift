//
//  QuizComponent.swift
//  App_Quizzes
//
//  Created by jorge suarez on 4/11/24.
//

import SwiftUI

struct QuizComponent: View {
    var quizzesModel: QuizzesModel
    
    var body: some View {
        NavigationView{
            List {
                ForEach(quizzesModel.quizzes) { quizItem in
                    NavigationLink(destination:RowView(quizItem:quizItem)){
                        HStack(alignment: .top, spacing: 15) {
                            if let url = quizItem.attachment?.url {
                                    AsyncImage(url: url) { image in
                                        image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                                        .shadow(color: .gray, radius: 5)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    }
                                
                            } else {
                                    Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                    .foregroundColor(.gray)
                                    .shadow(color: .gray, radius: 5)
                                                        }
                        
                            VStack(alignment: .leading,spacing: 3){
                                Text(quizItem.question)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    .foregroundColor(.primary)
                                    .lineLimit(2)
                                    .padding(.top, 5)
                                                            
                                
                                if let author = quizItem.author?.profileName{
                                    Text(author)
                                        .font(.subheadline)
                                    
                                }else if let admin = quizItem.author?.username{
                                    Text(admin)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }else{
                                    Text("Anónimo")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            

                                
                            
                        }
                    }
                    .frame(maxWidth:.infinity,alignment: .leading)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
            }
            .navigationTitle("Quizzes")
        }
    }
    
    
    // Vista previa
    struct QuizComponent_Previews: PreviewProvider {
        static var previews: some View {
            let quizzesModel = QuizzesModel()
            quizzesModel.load()
            return QuizComponent(quizzesModel: quizzesModel)
        }
    }
}
