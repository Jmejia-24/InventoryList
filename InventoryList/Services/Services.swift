//
//  Services.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import CoreData

protocol Serviceable {
    func fetch(completion: @escaping (Result<[NSManagedObject], Failure>) -> ())
    func create(product: Product, completion: @escaping (Result<Bool, Failure>) -> ())
    func delete(productManagedObject: NSManagedObject, completion: @escaping (Result<Bool, Failure>) -> ())
    func update(productManagedObject: ProductObject, completion: @escaping (Result<Bool, Failure>) -> ())
}

final class Services {
    private let storage: Storage
    
    required init(storage: Storage) {
        self.storage = storage
    }
}

extension Services: Serviceable {
    
    func fetch(completion: @escaping (Result<[NSManagedObject], Failure>) -> ()) {
        storage.fetch { result in
            switch result {
                case .success(let todos):
                    if let todos = todos {
                        completion(.success(todos))
                    } else {
                        completion(.failure(.storageDataGenel))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func create(product: Product, completion: @escaping (Result<Bool, Failure>) -> ()) {
        storage.create(object: product) { (result) in
            switch result {
                case .success(_):
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(.error(error)))
            }
        }
    }
    
    func delete(productManagedObject: NSManagedObject, completion: @escaping (Result<Bool, Failure>) -> ()) {
        storage.delete(object: productManagedObject) { (result) in
            switch result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func update(productManagedObject: ProductObject, completion: @escaping (Result<Bool, Failure>) -> ()) {
        storage.update(object: productManagedObject) { (result) in
            switch result {
                case .success(_):
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
