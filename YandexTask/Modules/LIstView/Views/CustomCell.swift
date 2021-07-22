//
//  CustomCell.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
     var logoCompany: UIImage?
     let messageView = UITextView()
     let abbreviationLabel =  UILabel()
     let corporationNameLabel = UILabel()
     let currentPriceLabel = UILabel()
     let differenceLabel = UILabel()
     var isFavourite: Bool = false
     let starIcon = UIImage(systemName: "star.square")
     let logoCompanyImageView = UIImageView ()
     weak var tapDelegate: ListViewController!
     let buttonStar = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(logoCompanyImageView)
        self.addSubview(abbreviationLabel)
        self.addSubview(corporationNameLabel)
        self.addSubview(currentPriceLabel)
        self.addSubview(differenceLabel)
        //self.addSubview(starImageView)
        self.addSubview(buttonStar)
        contentView.isUserInteractionEnabled = false
        
        configureLogoView()
        configureAbbreviationLabel()
        configureCorporationNameLabel()
        configureCurrentPriceLabel()
        configureDifferenceLabel()
        configureStarButton()

    }
    private func configureStarButton() {
        buttonStar.translatesAutoresizingMaskIntoConstraints = false
        buttonStar.setImage(UIImage(named: "emptyStar"), for: .normal)
        buttonStar.resignFirstResponder()
        NSLayoutConstraint.activate([
            buttonStar.topAnchor.constraint(equalTo: abbreviationLabel.topAnchor, constant: 1),
            buttonStar.leadingAnchor.constraint(equalTo: abbreviationLabel.trailingAnchor, constant: 6),
            buttonStar.heightAnchor.constraint(equalToConstant: 16),
            buttonStar.widthAnchor.constraint(equalTo: buttonStar.heightAnchor)
            
        ])
    }
    private func configureLogoView() {
        logoCompanyImageView.layer.cornerRadius = 10
        logoCompanyImageView.clipsToBounds = true
        logoCompanyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoCompanyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoCompanyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logoCompanyImageView.heightAnchor.constraint(equalToConstant: 52),
            logoCompanyImageView.widthAnchor.constraint(equalTo: logoCompanyImageView.heightAnchor),
        ])
    }
    @objc func starButtonClick() {
        
        tapDelegate.starTapped(cell: self)
    }
    private func configureAbbreviationLabel() {
    
        abbreviationLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        abbreviationLabel.textAlignment = .left
        abbreviationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abbreviationLabel.leadingAnchor.constraint(equalTo: self.logoCompanyImageView.trailingAnchor, constant: 12),
            abbreviationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
        ])
    }
    
    private func configureCorporationNameLabel() {
        corporationNameLabel.font = UIFont(name: "Helvetica", size: 12)
        corporationNameLabel.adjustsFontSizeToFitWidth = false
        corporationNameLabel.minimumScaleFactor = 0.5
        corporationNameLabel.adjustsFontSizeToFitWidth = false
        corporationNameLabel.lineBreakMode = .byTruncatingTail
        corporationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            corporationNameLabel.leadingAnchor.constraint(equalTo: self.abbreviationLabel.leadingAnchor),
            corporationNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.differenceLabel.leadingAnchor),
            corporationNameLabel.topAnchor.constraint(equalTo: self.abbreviationLabel.bottomAnchor)
        ])
        corporationNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
    
    private func configureCurrentPriceLabel() {
        currentPriceLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        currentPriceLabel.textAlignment = .right
        currentPriceLabel.sizeToFit()
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            currentPriceLabel.topAnchor.constraint(equalTo: self.abbreviationLabel.topAnchor)
        ])
    }
    
    private func configureDifferenceLabel() {
        differenceLabel.font = UIFont(name: "Helvetica", size: 12)
        differenceLabel.textAlignment = .right
        differenceLabel.sizeToFit()
        differenceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            differenceLabel.topAnchor.constraint(equalTo: self.currentPriceLabel.bottomAnchor),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
        differenceLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if logoCompany != nil{
            logoCompanyImageView.image = logoCompany
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
