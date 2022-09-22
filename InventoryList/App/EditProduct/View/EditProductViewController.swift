//
//  EditProductViewController.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

final class EditProductViewController: UIViewController {
    private let viewModel: EditProductViewModel
    private var contentView: ProductView?
    
    init(viewModel: EditProductViewModel) {
        self.viewModel = viewModel
        if let product = viewModel.productObject.product {
            self.contentView = ProductView(product: product)
        }
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
        title = "Edit Product"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", primaryAction: UIAction { [unowned self] _ in
            makeProduct()
        })
    }
    
    private func makeProduct() {
        guard let title = contentView?.titleProduct, !title.isEmpty,
              let price = contentView?.priceProduct, !price.isEmpty,
              let description = contentView?.descriptionProduct, !description.isEmpty,
              let productData = viewModel.productObject.product
        else {
            presentAlert(title: "Warning", message: "You should write a title, price and a description 😁")
            return
        }
        let product = Product(id: productData.id,
                              title: title,
                              description: description,
                              price: price,
                              isSoldOut: productData.isSoldOut)
        viewModel.update(product: product)
        navigationController?.popViewController(animated: true)
    }
}
