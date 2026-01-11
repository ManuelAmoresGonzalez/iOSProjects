//
//  MockProductManager.swift
//  DependencyInjection
//
//  Created by Manuel Enrique Amores Gonzalez on 19/5/25.
//

class MockProductManager: ProductManagerProtocol {
    func retrieveProducts(completion: @escaping ([String]) -> Void) {
        completion(["iphone", "ipad", "macbook"])
    }
    
}
