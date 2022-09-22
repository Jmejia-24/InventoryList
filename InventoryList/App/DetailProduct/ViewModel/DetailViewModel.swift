//
//  DetailViewModel.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import Foundation

final class DetailViewModel {
    
    weak var transitionDelegate: TransitionDelegate?
    var productViewData: ProductViewData
    
    init(productViewData: ProductViewData, store: Services) {
        self.productViewData = productViewData
    }
}
