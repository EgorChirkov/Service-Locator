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
                Button{
                    viewModel.onSaveList()
                }label: {
                    Text("Save")
                }
                
//                Button {
//                    viewModel.onClearAll()
//                } label: {
//                    Text("Clear")
//                }
            }
        }
        .onAppear{
            viewModel.onAppear()
        }
        .task {
            if !viewModel.isSavedState{
                try? await viewModel.fetchData()
            }
          
        }
        .refreshable {
            if !viewModel.isSavedState{
                try? await viewModel.fetchData()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
