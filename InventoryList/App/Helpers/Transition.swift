//
//  Transition.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/20/22.
//

import Foundation

protocol TransitionDelegate: AnyObject {
    func process(transition: Transition, with model: Any?)
}

enum Transition {
    case showMainScreen
    case showAdd
    case showEdit
    case showDetailView
}
