//
//  Networking.swift
//  Networking-Combine
//
//  Created by apple on 30/03/23.
//

import Foundation
import Combine


class webservice {
    
    func getPosts() -> AnyPublisher<[Posts],Error> {
        
        guard let serverURL = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: serverURL)
            .map {$0.data}
            .decode(type: [Posts].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
