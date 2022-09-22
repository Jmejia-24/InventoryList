//
//  MainViewModelProtocol.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

protocol MainViewModelProtocol {
    
    var viewModelDelegate: MainViewModelViewDelegate? { get set }

    func numberOfRows() -> Int
    
    func cellDataFor(row: Int) -> ProductViewData
  
    func start()
    
    func addButtonTapped()
    
    func deleteButtonTapped(at: IndexPath)
    
    func editButtonTapped(at: IndexPath)
    
    func didSelectRow(_ row: Int)
    
    func productStateButtonTapped(at: IndexPath, state: Bool)
}

protocol MainViewModelViewDelegate {
    func refreshScreen()
    func selectedTodoAtRow() -> Int
    func showError(errorMessage: String)
}
