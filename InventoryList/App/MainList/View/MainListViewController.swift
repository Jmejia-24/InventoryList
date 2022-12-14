//
//  MainListViewController.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/20/22.
//

import UIKit

final class MainListViewController: UITableViewController {
    
    private var viewModel: MainListViewModel
    
    init(viewModel: MainListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewModelDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.start()
    }
    
    // MARK: - Private methods
    
    private func setUI() {
        view.backgroundColor = .white
        title = "Products"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction { [unowned self] _ in
            viewModel.addButtonTapped()
        })
        viewModel.start()
    }

    private func stateButtonConfiguration(for indexPath: IndexPath, state: Bool) -> UIButton {
        let symbolName = state ? "checkmark.circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()

        let action = UIAction { [unowned self] _ in
            var newState = state
            newState.toggle()
            viewModel.productStateButtonTapped(at: indexPath, state: newState)
        }

        button.addAction(action, for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.sizeToFit()
        return button
    }
}

extension MainListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        var configuration = cell.defaultContentConfiguration()
        let cellData = viewModel.cellDataFor(row: indexPath.row)
        configuration.text = cellData.title.capitalized
        configuration.secondaryText = "$ \(cellData.price)"
        
        cell.contentConfiguration = configuration
        
        cell.accessoryView = stateButtonConfiguration(for: indexPath, state: cellData.isSoldOut)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [unowned self] _,_,_ in
            viewModel.deleteButtonTapped(at: indexPath)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            [unowned self] _,_,_ in
            viewModel.editButtonTapped(at: indexPath)
        }
        
        editAction.backgroundColor = .blue
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row)
    }
}

extension MainListViewController: MainViewModelViewDelegate {
    func refreshScreen() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func selectedTodoAtRow() -> Int {
        tableView.indexPathForSelectedRow?.row ?? 0
    }
    
    func showError(errorMessage: String) {
        presentAlert(title: "Error", message: errorMessage)
    }
}
