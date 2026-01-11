//
//  InjectionMethod.swift
//  DependencyInjection
//
//  Created by Manuel Enrique Amores Gonzalez on 19/5/25.
//

class DataManagerInjectionMethod {
    
    func getData(service: DataServiceProtocol) -> String {
        return service.getData()
    }
}

let networkService = NetWorkService()
let dataManagerInjectionMethod = DataManagerInjectionMethod()
let result = dataManagerInjectionMethod.getData(service: networkService)
