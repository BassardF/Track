import Foundation
import CoreData

class ExerciceDAO {
    
    let EntityName = "Exercice"
    
    let managedContext : NSManagedObjectContext?
    
    init(appDelegate : AppDelegate){
        managedContext = appDelegate.managedObjectContext!
    }
    
    func create (name : String){
        
        let entity =  NSEntityDescription.entityForName(EntityName, inManagedObjectContext: managedContext!)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        person.setValue(name, forKey: "name")
        
        var error: NSError?
        if !managedContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    func get () -> [NSManagedObject]{

        let fetchRequest = NSFetchRequest(entityName:EntityName)
        
        var error: NSError?
        
        let fetchedResults = managedContext!.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            return results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        return []
    }
    
    func delete (exercice : NSManagedObject){
        managedContext!.deleteObject(exercice)
        managedContext!.save(nil)
    }
}

