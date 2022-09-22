//
//  DetailView.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import Foundation

import UIKit

final class DetailView: UIView {
    
    let product: ProductViewData

    init(productViewData: ProductViewData) {
        self.product = productViewData
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var productTitle: DetailDescriptionView = {
        return DetailDescriptionView(title: "Title")
    }()
    
    private lazy var productDescription: DetailDescriptionView = {
        return DetailDescriptionView(title: "Description")
    }()
    
    private lazy var productPrice: DetailDescriptionView = {
        DetailDescriptionView(title: "Price")
    }()
    
    private lazy var productSaleStatus: DetailDescriptionView = {
        return DetailDescriptionView(title: "Sale Status")
    }()
    
    private func setUI() {
        productTitle.setText(product.title)
        productPrice.setText("$ \(product.price)")
        productDescription.setText(product.description)
        productSaleStatus.setText(product.isSoldOut ? "Sold Out" : "Unsold")
    }
}

extension DetailView: ViewCodeProtocol {
    
    func setupHierarchy() {
        containerStackView.addArrangedSubview(productTitle)
        containerStackView.addSpacing(20)
        containerStackView.addArrangedSubview(productPrice)
        containerStackView.addSpacing(20)
        containerStackView.addArrangedSubview(productSaleStatus)
        containerStackView.addSpacing(20)
        containerStackView.addArrangedSubview(productDescription)
        
        scrollView.addSubview(containerStackView)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            containerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    func additionalSetup() {
        backgroundColor = .tertiarySystemBackground
        setUI()
    }
}
