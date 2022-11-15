//
//  SampleRowItem.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import Foundation

struct SampleRowItem{
    var index: Int? = nil
    let text: String
    
    static func testValue() -> SampleRowItem{
        return SampleRowItem(index: 1,
                             text: "Text")
    }
}
