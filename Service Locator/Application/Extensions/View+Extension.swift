//
//  View+Extension.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import SwiftUI

extension View{
    func buttonCounterTextStyle(isEnabled: Bool) -> some View{
        modifier(ButtonCounter(isEnabled: isEnabled))
    }
}

struct ButtonCounter: ViewModifier{
    
    var isEnabled: Bool = true
    
    func body(content: Content) -> some View{
        content
            .frame(width: 40, height: 40)
            .background(isEnabled ? .blue.opacity(0.4) : .gray.opacity(0.4))
            .cornerRadius(20)
            .font(.system(size: 30))
            .foregroundColor(.white)
    }
}
