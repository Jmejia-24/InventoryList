//
//  AddProductView.swift
//  InventoryList
//
//  Created by Byron Mejia on 9/21/22.
//

import UIKit

final class AddProductView: UIView {
    let descriptionPlaceHolderText = "Write description of your product here! "

    var titleProduct: String { titleTextField.text ?? "" }
    var priceProduct: String { priceTextField.text ?? "" }
    var descriptionProduct: String { descriptionTextView.text }
    
    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Price"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.textAlignment = .natural
        textView.text = descriptionPlaceHolderText
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 1
        return textView
    }()
    
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
}

extension AddProductView: ViewCodeProtocol {
    
    func setupHierarchy() {
        containerStackView.addArrangedSubview(titleTextField)
        containerStackView.addSpacing(8)
        containerStackView.addArrangedSubview(priceTextField)
        containerStackView.addSpacing(8)
        containerStackView.addArrangedSubview(descriptionTextView)
        
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
        
        NSLayoutConstraint.activate([
            descriptionTextView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func additionalSetup() {
        backgroundColor = .tertiarySystemBackground
    }
}

extension AddProductView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if !descriptionTextView.text!.isEmpty && descriptionTextView.text! == descriptionPlaceHolderText {
            descriptionTextView.text = ""
            descriptionTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = descriptionPlaceHolderText
            descriptionTextView.textColor = .lightGray
        }
    }
}
