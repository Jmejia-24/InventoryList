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
    
    private func update(productObject: ProductObject) {
        services.update(productManagedObject: productObject) { [unowned self] result in
            switch result {
                case .success:
                    start()
                case .failure(let error):
                    print(error)
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
    
    func productStateButtonTapped(at: IndexPath, state: Bool) {
        guard let productObjectType = productObjects?[at.row],
              var productObj = productObjectType as? ProductObject,
        let product = productObj.product else { return }
        let newProduct = Product(id: product.id,
                                 title: product.title,
                                 description: product.description,
                                 price: product.price,
                                 isSoldOut: state)
        
        productObj.product = newProduct
        update(productObject: productObj)
    }
    
    func deleteButtonTapped(at: IndexPath) {
        delete(index: at.row)
    }
    
    func editButtonTapped(at: IndexPath) {
        guard let productObject = productObjects?[at.row] else { return }
        transitionDelegate?.process(transition: .showEdit, with: productObject)
    }
    
    func didSelectRow(_ row: Int) {
        guard let product = productObjects?[row].product else { return }
        let productViewData = ProductViewData(product: product)
        transitionDelegate?.process(transition: .showDetailView, with: productViewData)
    }
    
}
