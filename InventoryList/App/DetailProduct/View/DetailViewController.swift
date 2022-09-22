//
//  DetailViewController.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import Foundation

import UIKit

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    private var contentView: DetailView?
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        self.contentView = DetailView(productViewData: viewModel.productViewData)
        
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
        title = "Detail Product"
    }
}
