//
//  SampleRowViewModel.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import SwiftUI
import UniformTypeIdentifiers

class SampleRowViewModel: ObservableObject{
    
    @Published var item: SampleRowItem? = nil
    
    @Published var isShowAlert: Bool = false
    
    let localized: Localized = .init()
    
    var fact: String{
        guard let index = index, let text = text else {
            return localized.txtEmptyText
        }
        return "\(index + 1). \(text)"
    }
    
    private var index: Int?{
        guard let index = item?.index else {
            return nil
        }
        return index
    }
    
    private var text: String?{
        guard let text = item?.text, !text.isEmpty else {
            return nil
        }
        return text
    }
    
    func onAppear(item: SampleRowItem){
        self.item = item
    }
    
    func copyToClipboard(){
        guard let text = text else {
            return
        }
        UIPasteboard.general.setValue(text, forPasteboardType: UTType.plainText.identifier)
        
        isShowAlert.toggle()
    }
    
    struct Localized{
        let txtEmptyText: String = "empty text"
        let txtCopied: String = "Copied to clipboard"
    }
}
