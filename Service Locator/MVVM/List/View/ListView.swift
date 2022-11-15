//
//  ListView.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var viewModel: ListViewModel = .init()
    
    var body: some View{
        NavigationView {
            VStack{
                switch viewModel.isLoading{
                case true:
                    ProgressView(viewModel.localized.txtLoading)
                        .scaleEffect(1.25)
                case false:
                    List{
                        ForEach(viewModel.listItems, id: \.id){ item in
                            SampleRowView(item: item)
                        }
                    }
                }
            }
            .navigationTitle(viewModel.localized.txtTitle)
            .toolbar {
                    Button("Save List") {
                        viewModel.onSaveList()
                    }
                }
        }
        .onAppear{
            viewModel.onAppear()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
