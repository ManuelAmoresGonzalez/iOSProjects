//
//  CarsViewController.swift
//  ReviewArticles
//
//  Created by Manuel Enrique Amores Gonzalez on 22/10/25.
//
import UIKit

class CarsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let valor = Bundle.main.object(forInfoDictionaryKey: "hola") as? String else { return }
        print(valor)
    }
}
