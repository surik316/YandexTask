//
//  FinancialView.swift
//  YandexTask
//
//  Created by Максим Сурков on 04.04.2021.
//

import Foundation
import UIKit

class PreviousDayView: UIView {
    
    let stackView = UIStackView()
    
    let highestPriceLabel = UILabel()
    let lowestPriceLabel = UILabel()
    let openPriceLabel = UILabel()
    let closePriceLabel = UILabel()
    
    let highestPriceNameLabel = UILabel()
    let lowestPriceNameLabel = UILabel()
    let openPriceNameLabel = UILabel()
    let closePriceNameLabel = UILabel()
    
    let highestPriceView = UIView()
    let lowestPriceView = UIView()
    let openPriceView = UIView()
    let closePriceView = UIView()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        addSubview(stackView)
        setupStackView()
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(highestPriceView)
        stackView.addArrangedSubview(lowestPriceView)
        stackView.addArrangedSubview(openPriceView)
        stackView.addArrangedSubview(closePriceView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        setupLabels()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 25.0
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        setupView(subView: highestPriceView, labelName: highestPriceNameLabel, labelPrice: highestPriceLabel)
        setupView(subView: lowestPriceView, labelName: lowestPriceNameLabel, labelPrice: lowestPriceLabel)
        setupView(subView: openPriceView, labelName: openPriceNameLabel, labelPrice: openPriceLabel)
        setupView(subView: closePriceView, labelName: closePriceNameLabel, labelPrice: closePriceLabel)

    }
    func setupLabels() {
        closePriceNameLabel.text = "Close price:"
        highestPriceNameLabel.text = "The Highest price:"
        lowestPriceNameLabel.text = "The Lowest price:"
        openPriceNameLabel.text = "Open price:"
        closePriceNameLabel.textAlignment = .center
        highestPriceNameLabel.textAlignment = .center
        lowestPriceNameLabel.textAlignment = .center
        openPriceNameLabel.textAlignment = .center
        
        closePriceNameLabel.font = UIFont(name: "Helvetica Bold", size: 24)
        highestPriceNameLabel.font = UIFont(name: "Helvetica Bold", size: 24)
        lowestPriceNameLabel.font = UIFont(name: "Helvetica Bold", size: 24)
        openPriceNameLabel.font = UIFont(name: "Helvetica Bold", size: 24)
        
        closePriceLabel.font = UIFont(name: "Helvetica Neue OTS", size: 26)
        highestPriceLabel.font = UIFont(name: "Helvetica Neue OTS", size: 26)
        lowestPriceLabel.font = UIFont(name: "Helvetica Neue OTS", size: 26)
        openPriceLabel.font = UIFont(name: "Helvetica Neue OTS", size: 26)
    }
    func setupView(subView: UIView, labelName: UILabel, labelPrice: UILabel) {
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        subView.layer.cornerRadius = 27.5
        subView.backgroundColor = UIColor.rgba(243, 243, 243)
        subView.addSubview(labelName)
        subView.addSubview(labelPrice)
        
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: subView.topAnchor, constant: 20),
            labelName.centerXAnchor.constraint(equalTo: subView.centerXAnchor),
            
            labelPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20),
            labelPrice.centerXAnchor.constraint(equalTo: labelName.centerXAnchor),
            labelPrice.trailingAnchor.constraint(lessThanOrEqualTo: labelName.trailingAnchor)
    
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
