//
//  AddProductCoordinator.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

final class AddProductCoordinator: Coordinator {
    
    var model: Any?
    var navigationController: UINavigationController?
    weak var transitionDelegate: TransitionDelegate?
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = AddProductViewModel(store: Services(storage: ProductStorageManager()))
        viewModel.transitionDelegate = transitionDelegate
        let viewController = AddProductViewController(viewModel: viewModel)
        return viewController
    }()
    
    func start() {
        navigationController?.pushViewController(primaryViewController, animated: true)
    }
}
