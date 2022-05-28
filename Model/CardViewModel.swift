//
//  DataViewModel.swift
//  ReadDataFromDB (iOS)
//
//  Created by Сергей Кривошеев on 05.03.2022.
//

import Foundation
import Combine

class CardViewModel: ObservableObject, Identifiable {
    @Published var dataCard:Data
    var id = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(data: Data){
        self.dataCard = data
        $dataCard
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
