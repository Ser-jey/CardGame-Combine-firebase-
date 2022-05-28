//
//  ContentView.swift
//  Shared
//
//  Created by Сергей Кривошеев on 04.03.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataListViewMode: DataListViewModel
    @State var showingForm: Bool = false
    @State var showPassed:Bool = false
    var body: some View {
        NavigationView{
            
            VStack {
                List{
                    Toggle(!showPassed ? "showPassed" : "hidePassed", isOn: $showPassed)
                    
                    ForEach(dataListViewMode.cardViewModels.filter({
                        $0.dataCard.passed == showPassed
                    })){ cardViewModel in
                       CardView(cardViewModel: cardViewModel)
                    }.onDelete(perform: delete(at:))
                        .onMove { indexSet, index in
                            dataListViewMode.cardViewModels.move(fromOffsets: indexSet, toOffset: index)
                          }
                }.toolbar {
                    EditButton()
                  }
                
                .navigationTitle("CheckCard")
            
            
                ExtractedView(showingForm: $showingForm)
            }

        }
        
            
            
        }
    
    func delete(at offsets: IndexSet){
        offsets.map { dataListViewMode.cardViewModels[$0].dataCard}.forEach(dataListViewMode.remove)    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataListViewModel())
        
    }
}

struct ExtractedView: View {
    
    @EnvironmentObject var dataListViewMode: DataListViewModel
    @Binding var showingForm:Bool
    
    var body: some View {
        Button {
            // showingForm = true
            showingForm.toggle()
        } label: {
            Circle()
                .fill(Color.mint)
                .frame( height: 55)
                .shadow(radius: 3)
                .overlay( Image(systemName: "plus")).foregroundColor(Color.white)
            
        }.sheet(isPresented: $showingForm, onDismiss: nil){
            FormView(showingForm: $showingForm,dataListViewModel: _dataListViewMode)
        }
    }
}
