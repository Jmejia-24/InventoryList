//
//  MainListCoordinator.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/20/22.
//

import UIKit

final class MainListCoordinator: Coordinator {
    
    var model: Any?
    var navigationController: UINavigationController?
    weak var transitionDelegate: TransitionDelegate?
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = MainListViewModel(services: Services(storage: ProductStorageManager()))
        viewModel.transitionDelegate = transitionDelegate
        let viewController = MainListViewController(viewModel: viewModel)
        return viewController
    }()
    
    func start() {
        if navigationController?.viewControllers.isEmpty == false {
            navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(primaryViewController, animated: false)
    }
}
