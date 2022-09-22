//
//  EditProductViewModel.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import Foundation

final class EditProductViewModel {
    
    weak var transitionDelegate: TransitionDelegate?
    private let store: Services
    var productObject: ProductObject
    
    init(productObject: ProductObject, store: Services) {
        self.store = store
        self.productObject = productObject
    }
    
    func update(product: Product) {
        productObject.product = product
        store.update(productManagedObject: productObject) { result in
            switch result {
                case .success:
                    break
                case .failure(let error):
                    print(error)
            }
        }
    }
}
