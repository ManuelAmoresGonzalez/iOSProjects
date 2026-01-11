//
//  DependencyinjectionMethod.swift
//  DependencyInjection
//
//  Created by Manuel Enrique Amores Gonzalez on 19/5/25.
//
class DataManagerDependencyInjectionMethod {
    var dataService: DataServiceProtocol?
    
    func getData() -> String {
        return dataService?.getData() ?? "No data servcice available"
    }
}

let dataManagerDependencyInjectionMethod = DataManagerDependencyInjectionMethod()
let newtWorkService = NetWorkService()
//dataManagerDependencyInjectionMethod.dataService = newtWorkService

