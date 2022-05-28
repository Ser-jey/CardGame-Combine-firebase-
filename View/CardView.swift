//
//  CardView.swift
//  ReadDataFromDB (iOS)
//
//  Created by Сергей Кривошеев on 09.03.2022.
//

import SwiftUI

struct CardView: View {
    var dataListViewMode = DataListViewModel()
    @State var isFlipped = false
    var cardViewModel: CardViewModel
    
    var body: some View {
        
        CardViewChange()
            .onLongPressGesture {
                cardViewModel.dataCard.passed.toggle()
                let card = cardViewModel.dataCard
                dataListViewMode.update(card: card)
            }
        
    }
}




extension CardView {
    @ViewBuilder func CardViewChange() -> some View {
        RoundedRectangle(cornerRadius: 10)
       .fill(!isFlipped ? Color.mint : Color.cyan)
       .frame(height: 110)
       .shadow(radius: 2)
       .overlay(
       
           ZStack{
               Text(!isFlipped ? cardViewModel.dataCard.question : cardViewModel.dataCard.answer).font(.title2).padding(0).foregroundColor(Color.white)
           }
           
       )
       
       .onTapGesture {
           withAnimation {
               isFlipped.toggle()
               
           }
           
           
       }
       .padding(5)
    }
}




struct CardView_Previews: PreviewProvider {
   // @StateObject var ca
    
    static var previews: some View {
        CardView(cardViewModel: .init(data: Data(question:"kldmb" , answer: "dkmf")))
            
    }
}
