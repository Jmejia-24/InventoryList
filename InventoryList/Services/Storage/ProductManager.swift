//
//  ProductManager.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import CoreData

struct ProductStorageManager {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }
}

// MARK: CRUD Implementation

extension ProductStorageManager: Storage {
    func create<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ()) {
        guard let product = object as Any as? Product else {
            completion(.failure(.storageDataSave))
            return
        }
        
        let productEntity = ProductEntity(context: mainContext)
        
        productEntity.id = product.id ?? UUID().uuidString
        productEntity.isSoldOut = product.isSoldOut
        productEntity.price = product.price
        productEntity.title = product.title
        productEntity.productDescription = product.description
        
        do {
            try mainContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(.error(error)))
        }
    }
    
    func delete<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ()) {
        guard let productManagedObject = object as Any as? NSManagedObject else {
            completion(.failure(.storageDataGenel))
            return
        }
        
        mainContext.delete(productManagedObject)
        
        do {
            try mainContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(.error(error)))
        }
    }
    
    func update<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ()) {
        
        guard let productObject = object as Any as? ProductObject,
              let productData = productObject.product else {
                  completion(.failure(.storageDataGenel))
                  return
              }
        
        let productNSManagedObject = productObject.productNSManagedObject
        
        productNSManagedObject.setValue(productData.title, forKey: "title")
        productNSManagedObject.setValue(productData.price, forKey: "price")
        productNSManagedObject.setValue(productData.description, forKey: "productDescription")
        productNSManagedObject.setValue(productData.isSoldOut, forKey: "isSoldOut")
        
        do {
            try mainContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(.error(error)))
        }
    }
    
    func fetch<T>(completion: @escaping (Result<[T]?, Failure>) -> ()) where T : NSManagedObject {
        let fetchRequest = NSFetchRequest<T>(entityName: "ProductEntity")
        
        do {
            let producs = try mainContext.fetch(fetchRequest)
            completion(.success(producs))
        } catch {
            completion(.failure(.error(error)))
        }
    }
}
