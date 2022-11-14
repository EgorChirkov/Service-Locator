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
        VStack{
            switch viewModel.isLoading{
            case true:
                ProgressView()
            case false:
                List{
                    ForEach(viewModel.facts, id: \.self){ text in
                        SampleRowView(text: text)
                    }
                }
            }
        }
        .onAppear{
            viewModel.fetchData()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
