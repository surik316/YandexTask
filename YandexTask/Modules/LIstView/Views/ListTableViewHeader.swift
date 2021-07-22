//
//  ListTableViewHeader.swift
//  YandexTask
//
//  Created by Максим Сурков on 17.07.2021.
//

import Foundation
import UIKit
final class ListTableViewHeader: UIView  {
    let headerStock = UILabel()
    let headerFavourite = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    func setup() {
        addSubview(headerStock)
        addSubview(headerFavourite)
        backgroundColor = Colors.backgroundColor
        headerStock.translatesAutoresizingMaskIntoConstraints = false
        headerStock.text = "Stocks"
        headerStock.font = UIFont(name: "Helvetica-Bold", size: 28)
        headerStock.isUserInteractionEnabled = true
        
        headerFavourite.translatesAutoresizingMaskIntoConstraints = false
        headerFavourite.text = "Favourite"
        headerFavourite.font = UIFont(name: "Helvetica Bold", size: 18)
        headerFavourite.textColor = Colors.unselectedLabelColor
        headerFavourite.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            headerStock.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            headerStock.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            headerFavourite.leadingAnchor.constraint(equalTo: headerStock.trailingAnchor, constant: 20),
            headerFavourite.bottomAnchor.constraint(equalTo: headerStock.bottomAnchor),
            
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
