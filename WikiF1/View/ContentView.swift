//
//  ContentView.swift
//  WikiF1
//
//  Created by Pedro on 19/03/24.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .background(Color.white)
        }
        else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var Height: CGFloat = 140
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Height), spacing: 10)], spacing: 10) {
                ForEach (viewModel.drivers.prefix(20), id: \.self) { driver in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .frame(height: Height)
                        
                        LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .bottomTrailing)
                            .cornerRadius(10)
                            .ignoresSafeArea()
                        VStack {
                            URLImage(urlString: driver.headshot_url!)
                            Text(String(driver.driver_number))
                                .foregroundStyle(.white)
                            Text(driver.full_name)
                                .foregroundColor(.white)
                        }
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
