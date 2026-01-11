//
//  LoginViewControllerWithPrinciple.swift
//  SingleResponsibilityPrinciple
//
//  Created by Manuel Enrique Amores Gonzalez on 3/5/25.
//

import Foundation
import UIKit

class LoginViewControllerWithPrinciple: UIViewController {
    var loginService: LoginService?
    var userDatabaseManager: UserDatabaseManager?
    var loginRouter: LoginRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginService?.login{ [weak self] result in
            if result {
                self?.userDatabaseManager?.saveUser(user: User())
                self?.loginRouter?.presentHomeViewController()
            } else {
                ErrorMessage.showErrorMessage(tittle: "Tittle", message: "Message", viewController: LoginViewControllerWithPrinciple())
            }
        }
    }
}

class LoginService{
    func login(completion: @escaping (Bool) -> Void){
        URLSession.shared.dataTask(with: URL(string: "https://url")!) { [weak self] data, response, error in
            
            if let _ = error {
                completion(false)
            } else {
                completion(true)
            }
        }.resume()
    }
}

class UserDatabaseManager{
    func saveUser(user: User){
        
    }
}

class LoginRouter{
    weak var loginViewController: LoginViewControllerWithPrinciple?
    
    func presentHomeViewController(){
        let homeViewController = HomeViewController()
        loginViewController?.present(homeViewController, animated: true, completion: nil)
    }
}

class ErrorMessage{
    
   static func showErrorMessage(tittle: String, message: String, viewController: UIViewController){
        let alertController = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
