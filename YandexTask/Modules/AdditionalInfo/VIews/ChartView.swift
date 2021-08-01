//
//  ChartView.swift
//  YandexTask
//
//  Created by maksim.surkov on 25.07.2021.
//

import Foundation
import UIKit

class ChartView: UIView {
    
    var buttonBuy = UIButton()
    var currentPriceLabel = UILabel()
    var changePriceLabel = UILabel()
    var chartView =  LineChatView()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    func setup() {
        buttonBuy.backgroundColor = .black
        buttonBuy.setTitle("Buy", for: .normal)
        buttonBuy.titleLabel?.textColor = .white
        buttonBuy.titleLabel?.textAlignment = .center
        buttonBuy.layer.cornerRadius = 16
        buttonBuy.translatesAutoresizingMaskIntoConstraints = false
        
        currentPriceLabel.textAlignment = .center
        currentPriceLabel.textColor = .black
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        changePriceLabel.textAlignment = .center
        changePriceLabel.textColor = .green
        changePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.layer.cornerRadius = 20
        chartView.layer.borderWidth = 4
        chartView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        addSubview(currentPriceLabel)
        NSLayoutConstraint.activate([
            currentPriceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentPriceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40)
        ])
        
        addSubview(changePriceLabel)
        NSLayoutConstraint.activate([
            changePriceLabel.centerXAnchor.constraint(equalTo: currentPriceLabel.centerXAnchor),
            changePriceLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 8)
        ])
        
        addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chartView.topAnchor.constraint(equalTo: changePriceLabel.bottomAnchor, constant: 8),
            chartView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -212)
        ])
        
        addSubview(buttonBuy)
        NSLayoutConstraint.activate([
            buttonBuy.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonBuy.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonBuy.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonBuy.heightAnchor.constraint(equalToConstant: 58)
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
