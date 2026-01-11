//
//  ProductManagerProtocol.swift
//  DependencyInjection
//
//  Created by Manuel Enrique Amores Gonzalez on 19/5/25.
//
protocol ProductManagerProtocol {
    func retrieveProducts(completion: @escaping ([String]) -> Void)
}
