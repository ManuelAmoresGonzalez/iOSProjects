//
//  ViewController.swift
//  Caminatas
//
//  Created by Manuel Enrique Amores Gonzalez on 10/12/25.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = CoreDataStack.shared.context
    
    lazy var dateFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    //var caminatas: [Date] = []
    var currentPerson: Person?
    
    @IBOutlet weak var caminataTableView: UITableView!

    @IBAction func addCaminata(_ sender: Any) {
        guard let person = currentPerson else {
            print("No hay persona actual")
            return
        }
        
        let caminata = Caminata(context: context)
        caminata.date = Date()
        caminata.caminata = person  // Establecer relación inversa
        
        // Core Data maneja automáticamente la relación inversa
        person.addToMisCaminatas(caminata)
        
        CoreDataStack.shared.save()
        caminataTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caminataTableView.dataSource = self
        caminataTableView.delegate = self
        // Do any additional setup after loading the view.
        let personName: String = "Manuel"
        let personFetch: NSFetchRequest<Person> = Person.fetchRequest()
        personFetch.predicate = NSPredicate(format: "name == %@", personName)
        
        do {
            let results = try context.fetch(personFetch)
            
            if results.count > 0 {
                currentPerson = results.first
            } else {
                currentPerson = Person(context: context)
                currentPerson?.name = personName
                try context.save()
            }
        } catch let error as NSError {
            print("Algo ocurrio: \(error)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCaminatas", for: indexPath)
        
        guard let caminata = currentPerson?.misCaminatas?[indexPath.row] as? Caminata, let fechaCaminata = caminata.date else {
             return cell
        }
        
        cell.textLabel?.text = dateFormater.string(from: fechaCaminata)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let caminatas = currentPerson?.misCaminatas else {
            return 0
        }
        return caminatas.count
    }


}

