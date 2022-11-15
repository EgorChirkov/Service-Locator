//
//  SettingsView.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel: SettingsViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack{
                
                CounterView()
                    .environmentObject(viewModel)
            }
            .onAppear{
                viewModel.onAppear()
            }
            .onDisappear{
                viewModel.onDisappear()
            }
            .navigationTitle(viewModel.localized.txtSettings)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

private struct CounterView: View {
    
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                
                Text(viewModel.localized.txtCount)
                
                HStack{
                    Button {
                        viewModel.onAction(.down)
                    } label: {
                        Text("-")
                            .buttonCounterTextStyle(isEnabled: !viewModel.isDownDisabled)
                    }
                    .disabled(viewModel.isDownDisabled)
                    .buttonStyle(.plain)
                    .frame(width: geometry.size.width / 3)
                    
                    Text("\(viewModel.countFacts)")
                        .font(.system(size: 80))
                        .frame(width: geometry.size.width / 3)
                    
                    Button {
                        viewModel.onAction(.up)
                    } label: {
                        Text("+")
                            .buttonCounterTextStyle(isEnabled: !viewModel.isUpDisabled)
                    }
                    .disabled(viewModel.isUpDisabled)
                    .buttonStyle(.plain)
                    .frame(width: geometry.size.width / 3)
                }
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}
