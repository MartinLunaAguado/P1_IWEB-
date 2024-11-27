//
//  ContentView.swift
//  Prueba 11111
//
//  Created by d077 DIT UPM on 25/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    let quizzesModel = QuizzesModel()




    @State var errorMsg = "" {
        didSet{                                //cada vez que se cambie errorMsg ponemos a true el showErrorMsgAlert
            showErrorMsgAlert = true
        }
    }
    @State var showErrorMsgAlert = false
    @State var showAll = true


  
  
      @State var scoresModel = ScoresModel()

var body: some View {
        NavigationStack{
            List {
                Toggle("Ver Todos", isOn: $showAll)   //switch para cambiar todos

                    ForEach(quizzesModel.quizzes) { quizItem in
                        if showAll || scoresModel.pendiente(quizItem){
                            NavigationLink{
                            QuizItemPlayView(quizItem: quizItem, scoresModel: scoresModel, quizzesModel: quizzesModel)
                        } label: {
                            QuizItemRowView(quizItem: quizItem)
                        }
                    }
                    }
            }
            .navigationTitle("P4 Quizzes")     //METER EN LA SEGUNDA
            .navigationBarItems(
                leading: Text("RECORD = \(scoresModel.record.count)"),
                trailing: Button(action: {                             //BOTON DE REINICIAR SCORE
                    Task{                                                      //igual que onAppear pero cancela las descargas si se cambia de pantalla
                        do {
                            try await quizzesModel.download()
                            scoresModel.cleanup()
                        } catch {
                            errorMsg = error.localizedDescription
                        }
                        }
                }, label: {
                    Label("Refrescar", systemImage: "arrow.counterclockwise")
                }
                )
            )



        }
        .alert("Error",
            isPresented: $showErrorMsgAlert,
            actions: {
            },
            message: {
                Text(errorMsg)
            }
        )
        .task {                                     //igual que onAppear pero cancela las descargas si se cambia de pantalla
            do {
               try await quizzesModel.download()
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }

}


infix operator =+-= : ComparisonPrecedence

extension String {

    static func =+-=(s1:String, s2:String) -> Bool{
        var a = s1.lowercased().trimmingCharacters(in: .whitespaces)
        var b = s2.lowercased().trimmingCharacters(in: .whitespaces)
        return a==b
    }
    
}
  
  
  
  
  
  
  
  
  
  
  
  
  
    // var body: some View {
    //     VStack(alignment: .center, spacing: 20) {
    //         QuizComponent(quizzesModel: quizzesModel)
    //             .onAppear{
    //                 quizzesModel.load()
    //             }
                        
    //     }
    //     .padding(.top)
        
    // }


    //     VStack {
            
    //         Text("Hello, world!")
    //         .background(Color.red)

    //         Text("Hello,")
    //         .foregroundColor(.blue)
    //         .font(.largeTitle)
    //         Text("world!")
    //         .foregroundColor(.green)
    //         .font(.largeTitle)
    //     }
    //     .padding()
    // }
}

#Preview {
    ContentView()
}
