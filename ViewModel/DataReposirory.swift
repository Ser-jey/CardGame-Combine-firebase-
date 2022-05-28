//
//  DataViewModel.swift
//  ReadDataFromDB (iOS)
//
//  Created by Сергей Кривошеев on 04.03.2022.
//

import Foundation
import FirebaseFirestore

class DataReposirory: ObservableObject {
    
    @Published var data:[Data] = []
    private var store = Firestore.firestore()
    private var path: String = "Data"
    
    init(){
        get { data in
            self.data = data
        }
    }
    
    func get(completion: @escaping([Data]) -> Void){
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            let jsonData = snapshot?.documents.compactMap{
                try? $0.data(as: Data.self)
            } ?? []
            completion(jsonData)
       
            print(self.data)
            
        }
        
            
    }
    
    func add(_ data: Data){
        do{
          _ = try store.collection(path).addDocument(from: data)
        }catch{
            print("Adding a data failed")
        }
    }
    
    func remove(_ data: Data){
        guard let documentId = data.id else { return }
        store.collection(path).document(documentId).delete {error in
            if let error = error {
                print("Unable to delete a dataCard \(error.localizedDescription)")
            }
        }
    }
    
    func update(_ data: Data){
        guard let documentId = data.id else { return }
        do{
            try store.collection(path).document(documentId).setData(from: data)
        }catch{
            print("Updating a data failed ")
        }
    }
    
}
