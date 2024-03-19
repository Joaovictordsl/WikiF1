//
//  ViewModel.swift
//  WikiF1
//
//  Created by Pedro on 19/03/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var drivers: [Driver] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.openf1.org/v1/drivers") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let drivers = try JSONDecoder().decode([Driver].self, from: data)
                
                DispatchQueue.main.async {
                    self?.drivers = drivers
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
