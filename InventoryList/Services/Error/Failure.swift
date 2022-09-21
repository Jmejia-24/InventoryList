//
//  Failure.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import Foundation

enum Failure: Error {
    case storageDataSave
    case storageDataDelete
    case storageDataFetch
    case storageDataGenel
    case error(Error)
}
