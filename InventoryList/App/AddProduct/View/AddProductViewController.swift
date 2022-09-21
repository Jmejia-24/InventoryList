//
//  AddProductViewController.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

final class AddProductViewController: UIViewController {
    private let viewModel: AddProductViewModel
    private var contentView: AddProductView?
    
    init(viewModel: AddProductViewModel) {
        self.viewModel = viewModel
        self.contentView = AddProductView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        view = contentView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", primaryAction: UIAction { [unowned self] _ in
            makeProduct()
        })
    }
    
    private func makeProduct() {
        guard let title = contentView?.titleProduct, !title.isEmpty,
              let price = contentView?.priceProduct, !price.isEmpty,
              let description = contentView?.descriptionProduct,
              description != contentView?.descriptionPlaceHolderText,
              description != ""
        else {
            presentAlert(title: "Warning", message: "You should write a title, price and a description 😁")
            return
        }
        
        let product = Product(id: nil, title: title, description: description, price: price, isSoldOut: false)
        viewModel.add(product: product)
        navigationController?.popViewController(animated: true)
    }
}
