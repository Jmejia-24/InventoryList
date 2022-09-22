//
//  DetailCoordinator.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

final class DetailCoordinator: Coordinator {
    
    var model: Any?
    var navigationController: UINavigationController?
    weak var transitionDelegate: TransitionDelegate?
    
    func start() {
        guard let productViewData = model as? ProductViewData else { return }
        
        let viewModel = DetailViewModel(productViewData: productViewData,
                                             store: Services(storage: ProductStorageManager()))
        viewModel.transitionDelegate = transitionDelegate
        let viewController = DetailViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
