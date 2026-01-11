//
//  LoginViewControllerWithOpenClosed.swift
//  OpenClosedPrinciple
//
//  Created by Manuel Enrique Amores Gonzalez on 8/5/25.
//

import Foundation
import UIKit

class LoginViewControllerWithOpenClosed: UIViewController {
    var loginService: LoginServiceProtocol?
    var userDatabaseManager: UserDatabaseManager?
    var loginRouter: LoginRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginService?.login{ [weak self] result in
            if result {
                self?.userDatabaseManager?.saveUser(user: User())
                self?.loginRouter?.presentHomeViewController()
            } else {
                ErrorMessage.showErrorMessage(tittle: "Tittle", message: "Message", viewController: LoginViewControllerWithOpenClosed())
            }
        }
    }
}

class LoginBuilder{
    
    func createLoginViewControllerWithOpenClosed(loginService: LoginServiceProtocol) -> LoginViewControllerWithOpenClosed{
        let loginViewControllerWithOpenClosed = LoginViewControllerWithOpenClosed()
        loginViewControllerWithOpenClosed.loginService = loginService
        loginViewControllerWithOpenClosed.userDatabaseManager = UserDatabaseManager()
        loginViewControllerWithOpenClosed.loginRouter = LoginRouter()
        return loginViewControllerWithOpenClosed
    }
}

protocol LoginServiceProtocol{
    func login(completion: @escaping (Bool) -> Void)
    func start() -> LoginViewControllerWithOpenClosed
}

class LoginFacebookService: LoginServiceProtocol{
    func start() -> LoginViewControllerWithOpenClosed {
        let loginBuilder = LoginBuilder()
        let loginService = LoginFacebookService()

        let loginViewController = loginBuilder.createLoginViewControllerWithOpenClosed(loginService: self)

        loginViewController.loginRouter?.loginViewController = loginViewController
        
        return loginViewController
    }
    
    func login(completion: @escaping (Bool) -> Void){
        //SDK Facebook
        completion(true)
    }
}

class LoginService: LoginServiceProtocol{
    func login(completion: @escaping (Bool) -> Void){
        URLSession.shared.dataTask(with: URL(string: "https://url")!) { [weak self] data, response, error in
            
            if let _ = error {
                completion(false)
            } else {
                completion(true)
            }
        }.resume()
    }
    
    func start() -> LoginViewControllerWithOpenClosed {
        let loginBuilder = LoginBuilder()
        let loginService = LoginService() // o LoginFacebookService()

        let loginViewController = loginBuilder.createLoginViewControllerWithOpenClosed(loginService: self)

        loginViewController.loginRouter?.loginViewController = loginViewController
        
        return loginViewController
    }
}

class UserDatabaseManager{
    func saveUser(user: User){
        
    }
}

class LoginRouter{
    weak var loginViewController: LoginViewControllerWithOpenClosed?
    
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
