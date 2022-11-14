//
//  MainView.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel = .init()
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            
            ListView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
