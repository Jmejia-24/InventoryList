//
//  ProductViewDataType.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import Foundation

protocol ProductViewDataType: Hashable {
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var price: String { get }
    var isSoldOut: Bool { get }
}

struct ProductViewData: ProductViewDataType {
    
    var id: String { product.id ?? ""  }
    var title: String { product.title }
    var description: String { product.description }
    var price: String { product.price }
    var isSoldOut: Bool { product.isSoldOut }
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
}
