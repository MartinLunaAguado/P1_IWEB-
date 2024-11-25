//
//  ButtonFavourite.swift
//  App_Quizzes
//
//  Created by jorge suarez on 16/11/24.
//

import Foundation
import SwiftUICore
import SwiftUI

struct ButtonFavourite : View{
    @Binding var isFavourite : Bool
    
    var body : some View{
        Button(
            action:{toggleFavourite()}
        ){
            Image(systemName: isFavourite ? "star.fill" : "star")
                           .resizable()
                           .frame(width: 20, height: 20)
                           .foregroundColor(isFavourite ? .yellow : .gray)
        }
    }
    
    private func toggleFavourite(){
        isFavourite.toggle()
    }
}
