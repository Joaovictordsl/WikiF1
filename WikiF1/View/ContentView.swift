//
//  ContentView.swift
//  WikiF1
//
//  Created by Pedro on 19/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var Height: CGFloat = 140
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Height), spacing: 10)], spacing: 10) {
                ForEach (viewModel.drivers, id: \.self) { driver in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .frame(height: Height)
                        
                            LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .bottomTrailing)
                            .cornerRadius(10)
                            .ignoresSafeArea()
                        Text(driver.full_name)
                            .foregroundColor(.white)
                    }
                    
                }
            }
        }
        .padding(.horizontal, 10)
        .onAppear {
            viewModel.fetch()
        }
        
        
        //}
    }
}

#Preview {
    ContentView()
}
