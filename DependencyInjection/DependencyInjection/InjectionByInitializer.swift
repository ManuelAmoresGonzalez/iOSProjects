//
//  InjectionByInitializer.swift
//  DependencyInjection
//
//  Created by Manuel Enrique Amores Gonzalez on 19/5/25.
//

protocol DataServiceProtocol {
    func getData() -> String
}


class NetWorkService: DataServiceProtocol {
    func getData() -> String {
        return "Data from Network"
    }
}

class DataManager {
    
    private var dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    func getData() -> String {
        return dataService.getData()
    }
}

let netWorkService = NetWorkService()
let dataManager = DataManager(dataService: netWorkService)
