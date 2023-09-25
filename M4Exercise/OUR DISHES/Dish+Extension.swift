import Foundation
import CoreData


extension Dish {
    
    enum DishExistenceError: Error {
        case dishNotFound
        case databaseError(String)
    }

    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        
        for menuItem in menuItems {
            do {
                guard try !doesDishExist(name: menuItem.title, context: context) else { return }
                let dish = Dish(context: context)
                dish.name = menuItem.title
                dish.price = Float(menuItem.price) ?? -1.0
            } catch {
                print("There was an error: \(error)")
            }


        }
        
    }
    
    private static func doesDishExist(name: String, context: NSManagedObjectContext) throws -> Bool {
        print("**** does dishExist")
        guard let dishExist = Dish.exists(name: name, context) else {
            print("*** throws")
            throw DishExistenceError.dishNotFound
        }
        print("*** no throw : \(dishExist)")
        return dishExist
    }
    

    
}
