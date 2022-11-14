//
//  SampleRowView.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct SampleRowView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .onTapGesture {
                copyToClipboard(text)
            }
    }
    
    private func copyToClipboard(_ text: String){
        UIPasteboard.general.setValue(text,
            forPasteboardType: UTType.plainText.identifier)
        debugPrint("Copied to Clipboard: ", text)
    }
}

struct SampleRowView_Previews: PreviewProvider {
    static var previews: some View {
        SampleRowView(text: "text")
    }
}
