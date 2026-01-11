//
//  ViewController.swift
//  ReviewArticles
//
//  Created by Manuel Enrique Amores Gonzalez on 22/10/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var dataFromCoreData: [Automovil] = []
    var actualCar: Automovil?
    @IBOutlet weak var imageCar: UIImageView!
    
    @IBOutlet weak var selectCar: UISegmentedControl!
    
    @IBOutlet weak var modelCar: UILabel!
    
    @IBOutlet weak var qualifyCar: UILabel!
    
    @IBOutlet weak var lastUse: UILabel!
        
    @IBAction func buttonTest(_ sender: UIButton) {
        actualCar?.vecesProbado = (actualCar?.vecesProbado ?? 0) + 1
        actualCar?.ultimaPrueba = Date()
        updateVehiculo()
    }
    
    @IBAction func qualifyCar(_ sender: UIButton) {
        actualCar?.calificacion = 11
        updateVehiculo()
        print("Qualify")
    }
    
    @IBOutlet weak var numberTimesTested: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        populateCoreDataIfNeeded()
        fetchItems()
        populateFromCoreData()
        selectCar.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        actualCar = dataFromCoreData.first
    }
    
    func saveDataPListCoreData() -> [[String: Any]]?{
        
        guard let url = Bundle.main.url(forResource: "listInitialData", withExtension: "plist") else {
            print("⚠️ No se encontró listInitialData.plist en el bundle")
            return nil;
        }
        
        do {
            let data = try Data(contentsOf: url)
            let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            return plist as? [[String: Any]]
        } catch {
            print("❌ Error al leer plist: \(error.localizedDescription)")
            return nil;
        }
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        actualCar = dataFromCoreData[index]
        let actualCar = dataFromCoreData[index]
        imageCar.image = UIImage(data: actualCar.datosImagen ?? Data())

        modelCar.text = actualCar.nombre
        
        qualifyCar.text =  String(format: "%.1f", actualCar.calificacion)
        
        if let fecha = actualCar.ultimaPrueba {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            lastUse.text = formatter.string(from: fecha)
        }
        print("Auto seleccionado \(actualCar.busqueda)")
        numberTimesTested.text = String(Int(actualCar.vecesProbado))
    }
    
    func populateFromCoreData() {
        let firstIndex = dataFromCoreData.first
        imageCar.image = UIImage(data: firstIndex?.datosImagen ?? Data())
        for (index, auto) in dataFromCoreData.enumerated() {
            selectCar.setTitle(auto.busqueda, forSegmentAt: index)
        }

        modelCar.text = firstIndex?.nombre
        
        qualifyCar.text =  String(format: "%.1f", firstIndex?.calificacion ?? 0.0)
        
        if let fecha = firstIndex?.ultimaPrueba {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            lastUse.text = formatter.string(from: fecha)
        }
        
        numberTimesTested.text = String(Int(dataFromCoreData.first?.vecesProbado ?? 0))
        
        
    }
    
    func populateCoreDataIfNeeded() {
        let context = PersistenceController.shared.context
        
        // Verificar si ya hay datos
        let fetchRequest: NSFetchRequest<Automovil> = Automovil.fetchRequest()
        let count = (try? context.count(for: fetchRequest)) ?? 0
        guard count == 0 else {
            print("✅ Core Data ya tiene datos, no se importará el plist.")
            return
        }
        
        guard let items = saveDataPListCoreData() else { return }
        
        items.forEach { item in
            let auto = Automovil(context: context)
            auto.nombre = item["nombre"] as? String
            auto.busqueda = item["busqueda"] as? String
            auto.calificacion = (item["calificacion"] as? NSNumber)?.doubleValue ?? 0.0
            auto.vecesProbado = Int32((item["vecesProbado"] as? NSNumber)?.intValue ?? 0)
            auto.ultimaPrueba = Date()
            if let nombreArchivo = item["nombreImagen"] as? String,
               let imagen = UIImage(named: nombreArchivo),
               let datosImagen = imagen.jpegData(compressionQuality: 0.5) {
                
               auto.datosImagen = datosImagen
            } else {
                print("⚠️ No se pudo cargar la imagen con nombre: \(item["nombreImagen"] ?? "nil")")
            }
        }
        PersistenceController.shared.save()
    }

    func updateVehiculo() {
        PersistenceController.shared.save()
    }
        
    func fetchItems(){
        let context = PersistenceController.shared.context
        let request: NSFetchRequest<Automovil> = Automovil.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Automovil.nombre, ascending: false)]
        do {
            //print(try context.fetch(request)[0].datosImagen)
            dataFromCoreData = try context.fetch(request)
        } catch {
            print("Error al obtener items: \(error.localizedDescription)")
        }
    }
        
    func deleteItem() {
        let context = PersistenceController.shared.context
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Automovil.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                try context.save() // Guardar los cambios
                print("✅ Core Data limpio: todos los Automovil eliminados")
            } catch {
                print("❌ Error al limpiar Core Data: \(error.localizedDescription)")
            }
    }
}

