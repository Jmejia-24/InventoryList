//
//  AddProductViewModel.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

final class AddProductViewModel {
    
    weak var transitionDelegate: TransitionDelegate?
    private let store: Services
    
    init(store: Services) {
        self.store = store
    }
    
    func add(product: Product) {
        store.create(product: product) { result in
            switch result {
                case .success:
                    break
                case .failure(let error):
                    print(error)
            }
        }
    }
}
