//
//  EditProductCoordinator.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

final class EditProductCoordinator: Coordinator {
    
    var model: Any?
    var navigationController: UINavigationController?
    weak var transitionDelegate: TransitionDelegate?
    
    func start() {
        guard let productObject = model as? ProductObject else { return }
        let viewModel = EditProductViewModel(productObject: productObject,
                                             store: Services(storage: ProductStorageManager()))
        viewModel.transitionDelegate = transitionDelegate
        let viewController = EditProductViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
