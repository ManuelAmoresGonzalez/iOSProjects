//
//  LoginViewControllerWithInterfaceSegregation.swift
//  InterfaceSegregationPrinciple
//
//  Created by Manuel Enrique Amores Gonzalez on 16/5/25.
//
import Foundation
import UIKit

class LoginViewControllerWithInterfaceSegregation: UIViewController {
    var loginService: LoginServiceProtocol?
    var userDatabaseManager: UserDatabaseManagerProtocol?
    var loginRouter: LoginRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginService?.login{ [weak self] result in
            if result {
                self?.userDatabaseManager?.saveUser(user: User())
                self?.loginRouter?.presentHomeViewController()
            } else {
                ErrorMessage.showErrorMessage(tittle: "Tittle", message: "Message", viewController: LoginViewControllerWithInterfaceSegregation())
            }
        }
    }
}

class LoginBuilder{
    
    func createLoginViewControllerWithLiskov(loginService: LoginServiceProtocol) -> LoginViewControllerWithInterfaceSegregation{
        let loginViewControllerWithLiskov = LoginViewControllerWithInterfaceSegregation()
        loginViewControllerWithLiskov.loginService = loginService
        loginViewControllerWithLiskov.userDatabaseManager = UserDefaults()
        loginViewControllerWithLiskov.loginRouter = LoginRouter()
        return loginViewControllerWithLiskov
    }
}

protocol LoginServiceProtocol{
    func login(completion: @escaping (Bool) -> Void)
    func start() -> LoginViewControllerWithInterfaceSegregation
}

class LoginFacebookService: LoginServiceProtocol{
    func start() -> LoginViewControllerWithInterfaceSegregation {
        let loginBuilder = LoginBuilder()
        let loginService = LoginFacebookService()

        let loginViewController = loginBuilder.createLoginViewControllerWithLiskov(loginService: self)

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
    
    func start() -> LoginViewControllerWithInterfaceSegregation {
        let loginBuilder = LoginBuilder()
        _ = LoginService() // or LoginFacebookService()

        let loginViewController = loginBuilder.createLoginViewControllerWithLiskov(loginService: self)

        loginViewController.loginRouter?.loginViewController = loginViewController
        
        return loginViewController
    }
}

protocol UserDatabaseManagerProtocolWhitoutSegregationInterface {
    func loadDataBase()
    func saveUser(user: User)
}

protocol UserDatabaseManagerProtocol {
   func saveUser(user: User)
}

protocol DataBaseConfigurationProtocol {
    func loadDataBase()
}

class UserDatabaseManager: UserDatabaseManagerProtocol, DataBaseConfigurationProtocol{
    func loadDataBase() {
        //BD Configuration
    }
    
    func saveUser(user: User){
        //Save user on DB
    }
}

extension UserDefaults: UserDatabaseManagerProtocol{
    func saveUser(user: User){
        setValue(user, forKey: "user")
    }
}

class LoginRouter{
    weak var loginViewController: LoginViewControllerWithInterfaceSegregation?
    
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

