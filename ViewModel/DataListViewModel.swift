//
//  DataListViewModel.swift
//  ReadDataFromDB (iOS)
//
//  Created by Сергей Кривошеев on 05.03.2022.
//

import Foundation
import Combine

class DataListViewModel: ObservableObject {
    @Published var dataRepository = DataReposirory()
    @Published var cardViewModels:[CardViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(){
        dataRepository.$data
            .map { data in
                data.map(CardViewModel.init)
            }
            .assign(to: \.cardViewModels,on:self)
            .store(in: &cancellables)
            }
    
    
    func add(card: Data){
        dataRepository.add(card)
    }
    
    func remove(card: Data){
        dataRepository.remove(card)
    }
    
    func update(card: Data){
        dataRepository.update(card)
    }
}
