//
//  Storage.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import CoreData

protocol Storage {
    func create<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ())
    func delete<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ())
    func update<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ())
    func fetch<T: NSManagedObject>(completion: @escaping (Result<[T]?, Failure>) -> ())
}
