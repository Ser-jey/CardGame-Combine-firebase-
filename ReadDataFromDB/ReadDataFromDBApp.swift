//
//  ReadDataFromDBApp.swift
//  Shared
//
//  Created by Сергей Кривошеев on 04.03.2022.
//

import SwiftUI
import Firebase

@main
struct ReadDataFromDBApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataListViewModel())
             
        }
    }
}
