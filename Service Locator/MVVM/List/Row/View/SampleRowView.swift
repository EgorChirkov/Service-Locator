//
//  SampleRowView.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import SwiftUI

struct SampleRowView: View {
    
    let item: SampleRowItem
    
    @StateObject private var viewModel: SampleRowViewModel = .init()
    
    var body: some View {
        VStack{
            Text(viewModel.fact)
                .onTapGesture {
                    viewModel.copyToClipboard()
                }
        }
        .onAppear{
            viewModel.onAppear(item: item)
        }
        .alert(viewModel.localized.txtCopied, isPresented: $viewModel.isShowAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct SampleRowView_Previews: PreviewProvider {
    static var previews: some View {
        SampleRowView(item: SampleRowItem.testValue())
    }
}
