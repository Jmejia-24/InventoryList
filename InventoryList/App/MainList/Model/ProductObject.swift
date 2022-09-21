//
//  ProductObject.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import CoreData

protocol ProductObjectType {
    var productNSManagedObject: NSManagedObject { get set }
    var product: Product? { get }
    var productViewData: ProductViewData? { get }
}

struct ProductObject: ProductObjectType {
    private var _productNSManagedObject: NSManagedObject!
    
    var productNSManagedObject: NSManagedObject {
        set {
            _productNSManagedObject = newValue
            fillProductModel(from: newValue)
        }
        get { _productNSManagedObject }
    }
    
    private mutating func fillProductModel(from nsManagedObj: NSManagedObject){
        if let id = nsManagedObj.value(forKey: "id"),
           let title = nsManagedObj.value(forKey: "title"),
           let description = nsManagedObj.value(forKey: "productDescription"),
           let price = nsManagedObj.value(forKey: "price"),
           let isSoldOutObj = nsManagedObj.value(forKey: "isSoldOut") {
            let id = "\(id)"
            let title = "\(title)"
            let description = "\(description)"
            let price = "\(price)"
            let isSoldOut = isSoldOutObj
            
            product = Product(id: id,
                              title: title,
                              description: description,
                              price: price,
                              isSoldOut: isSoldOut as! Bool)
        }
    }
    
    var product: Product?
    
    var productViewData: ProductViewData? {
        get {
            guard let product = product else { return nil}
            return ProductViewData(product: product)
        }
    }
    
    init(nsManagedObject: NSManagedObject) {
        self.productNSManagedObject = nsManagedObject
    }
}
