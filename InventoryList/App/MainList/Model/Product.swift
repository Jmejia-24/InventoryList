//
//  Product.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import Foundation

struct Product: Hashable {
    let id: String?
    let title: String
    let description: String
    let price: String
    let isSoldOut: Bool
}
