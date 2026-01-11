//
//  TableViewController.swift
//  GuardaPalabras
//
//  Created by Manuel Enrique Amores Gonzalez on 4/9/25.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var managedObjects: [NSManagedObject] = []
    @IBAction func agregarPalabras(_ sender: Any) {
        let alert = UIAlertController(title: "Agregar Palabra", message: "Ingrese la palabra", preferredStyle: .alert)
        alert.addTextField()
        
        let guardar = UIAlertAction(title: "Agregar", style: .default) { (_) in
            
            guard let textField = alert.textFields?.first, textField.text!.count > 0 else { return }
            self.guardarPalabra(palabra: textField.text!)
            self.tableView.reloadData()

        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(guardar)
        alert.addAction(cancel)
        present(alert, animated: true , completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: "Lista")
        
        do {
            managedObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return managedObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = managedObjects[indexPath.row].value(forKey: "palabra") as? String

        return cell
    }
    
    func guardarPalabra(palabra: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Lista", in: managedContext) else { return }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        managedObject.setValue(palabra, forKeyPath: "palabra")
        
        do {
            try managedContext.save()
            managedObjects.append(managedObject)
        } catch let error as NSError{
            print("No se guardo, \(error)")
        }
    }
    

}
