//
//  FormView.swift
//  ReadDataFromDB (iOS)
//
//  Created by Сергей Кривошеев on 09.03.2022.
//

import SwiftUI

struct FormView: View {
    @StateObject var formViewModel = FormViewModel()
    @Binding var showingForm: Bool
    @EnvironmentObject var dataListViewModel:DataListViewModel
    
    var body: some View {
        VStack(){
            Form{
                Section(header:Text("Question"), footer: Text(formViewModel.inlineErrorForQuestion).foregroundColor(.red)) {
                    TextField("Question", text: $formViewModel.question)
                        .autocapitalization(.none)
                }
                Section(header: Text("ANSWER"), footer:Text(formViewModel.inlineErrorforAnswer).foregroundColor(.red)) {
                    TextField("Answer", text: $formViewModel.answer)
                        .autocapitalization(.none)
                }
                
                
            }
            Button {
                dataListViewModel.add(card: Data.init(question: formViewModel.question, answer: formViewModel.answer))
                    self.showingForm.toggle()
            } label: {
                // Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.mint)
                    .frame( height: 60)
                    .shadow(radius: 4)
                    .overlay(
                        ZStack{
                            Text("Add card")
                                .foregroundColor(Color.white)
                                .font(.title2)
                        }
                        // .foregroundColor(.white)
                     
                    )}.padding(10)
                .disabled(!formViewModel.isValid)
            
            
            
        }
    }
}


//struct FormView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FormView()
//            .environmentObject(DataListViewModel())
//    }
//}
