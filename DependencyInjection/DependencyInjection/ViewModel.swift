//
//  ViewModel.swift
//  DependencyInjection
//
//  Created by Manuel Enrique Amores Gonzalez on 19/5/25.
//
class ViewModel {
    
    var manager: ProductManagerProtocol
    var products: [String] = []
    
    init(manager: ProductManagerProtocol) {
        
        self.manager = manager
        manager.retrieveProducts() { [weak self] products in
            for product in products {
                print(product)
                self?.products = products
            }
        }
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
}
