//
//  BackgroundGradient.swift
//  Monopoly Calculator
//
//  Created by Nihal Memon on 6/25/22.
//

import SwiftUI

struct BackgroundGradient: View {
    @State var lightColorArray = [Color.purple, Color.cyan, Color.purple, Color.cyan]
    @State var darkColorArray = [Color.blue, Color.green, Color.blue, .green]
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            LinearGradient(colors: colorScheme == .light ? darkColorArray : lightColorArray , startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
}

struct BackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradient()
    }
}
