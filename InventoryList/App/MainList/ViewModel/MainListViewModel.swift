//
//  MainListViewModel.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/20/22.
//

import UIKit

final class MainListViewModel {
    
    weak var transitionDelegate: TransitionDelegate?
    var viewModelDelegate: MainViewModelViewDelegate?
    var services: Serviceable
    
    var productObjects: [ProductObjectType]? {
        didSet {
            viewModelDelegate?.refreshScreen()
        }
    }
    
    init(services: Serviceable) {
        self.services = services
    }
    
    func start() {
        fetch()
        viewModelDelegate?.refreshScreen()
    }
}

// MARK: - CoreData

extension MainListViewModel {
    private func fetch() {
        services.fetch { [unowned self] result in
            switch result {
                case .success(let productManagedObjects):
                    productObjects = productManagedObjects.compactMap{
                        ProductObject(nsManagedObject: $0)
                    }
                case .failure(let error):
                    viewModelDelegate?.showError(errorMessage: error.localizedDescription)
            }
        }
    }
    
    private func delete(index: Int) {
        guard let productManagedObject = productObjects?[index].productNSManagedObject else { return }
        services.delete(productManagedObject: productManagedObject) { [unowned self] result in
            switch result {
                case .success:
                    print("successfully deleted")
                    start()
                case .failure(let error):
                    viewModelDelegate?.showError(errorMessage: error.localizedDescription)
            }
        }
    }
}

extension MainListViewModel: MainViewModelProtocol {
    
    func numberOfRows() -> Int {
        productObjects?.count ?? 0
    }
    
    func cellDataFor(row: Int) -> ProductViewData {
        guard let viewData = productObjects?[row].productViewData else {
            let product = Product(id: "", title: "", description: "", price: "", isSoldOut: false)
            return ProductViewData(product: product)
        }
        return viewData
    }
    
    func addButtonTapped() {
        transitionDelegate?.process(transition: .showAdd, with: nil)
    }
    
    func deleteButtonTapped(at: IndexPath) {
        delete(index: at.row)
    }
    
    func editButtonTapped(at: IndexPath) {
        let productObject = productObjects![at.row]
        transitionDelegate?.process(transition: .showEdit, with: productObject)
    }
    
    func didSelectRow(_ row: Int) {
        guard let product = productObjects?[row].product else { return }
        let productViewData = ProductViewData(product: product)
        transitionDelegate?.process(transition: .showDetailView, with: productViewData)
    }
    
}
