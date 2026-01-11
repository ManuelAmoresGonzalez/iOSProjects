//
//  ViewController.swift
//  LifeCycleFirst
//
//  Created by Manuel Enrique Amores Gonzalez on 24/10/25.
//

import UIKit

class ViewController: UIViewController {
    

    @IBAction func buttonotherview(_ sender: UIButton) {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ viewDidLoad - Se cargó la vista.")
        view.backgroundColor = .systemBlue
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("👀 viewWillAppear - La vista aparecerá.")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("🌟 viewDidAppear - La vista ya es visible.")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("👋 viewWillDisappear - La vista se va a ocultar.")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("💤 viewDidDisappear - La vista ya se ocultó.")
    }

}

