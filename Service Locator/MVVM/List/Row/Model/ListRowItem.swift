//
//  SampleRowItem.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import Foundation

struct ListRowItem{
    let id: Int
    let text: String
    
    static func testValue() -> ListRowItem{
        return ListRowItem(id: 1,
                             text: "Text")
    }
}
