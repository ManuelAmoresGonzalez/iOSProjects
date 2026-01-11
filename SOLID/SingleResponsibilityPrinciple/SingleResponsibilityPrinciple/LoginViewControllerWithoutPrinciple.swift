//
//  LoginViewControllerWithoutPrinciple.swift
//  SingleResponsibilityPrinciple
//
//  Created by Manuel Enrique Amores Gonzalez on 3/5/25.
//

import Foundation
import UIKit

class LoginViewControllerWithoutPrinciple: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login{ [weak self] result in
            if result {
                self?.saveUser()
                self?.presentHomeViewController()
            } else {
                self?.showErrorMessage()
            }
        }
    }
    
    func login(completion: @escaping (Bool) -> Void){
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!) { [weak self] data, response, error in
            
            if let error = error {
                completion(false)
            } else {
                self?.saveUser()
                completion(true)
            }
        }.resume()
    }
    
    func saveUser(){
        //Save user on db
    }
    
    func presentHomeViewController(){
        let homeViewController = HomeViewController()
        present(homeViewController, animated: true, completion: nil)
    }
    
    func showErrorMessage(){
        let alertController = UIAlertController(title: "Error", message: "Login failed", preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
    }
}
