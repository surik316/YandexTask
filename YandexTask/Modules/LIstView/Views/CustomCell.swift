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
    var messageView = UITextView()
    var abbreviationLabel =  UILabel()
    var corporationNameLabel = UILabel()
    var currentPriceLabel = UILabel()
    var differenceLabel = UILabel()
    var isFavourite: Bool = false
    var starIcon = UIImage(systemName: "star.square")
    var logoCompanyImageView = UIImageView ()
    var starImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(logoCompanyImageView)
        self.addSubview(abbreviationLabel)
        self.addSubview(corporationNameLabel)
        self.addSubview(currentPriceLabel)
        self.addSubview(differenceLabel)
        self.addSubview(starImageView)
        
        configureLogoView()
        configureAbbreviationLabel()
        configureCorporationNameLabel()
        configureCurrentPriceLabel()
        configureDifferenceLabel()
        configureStarImageView()
        
        
        setLogoViewConstraint()
        setAbbreviationLabelConstraint()
        setCorporationNameLabelConstraint()
        setCurrentPriceLabelConstraint()
        setDiffernceConstraint()
        setStarImageViewConstraints()
       
    }
    
    func configureLogoView() {
        logoCompanyImageView.layer.cornerRadius = 10
        logoCompanyImageView.clipsToBounds = true
    }
    
    func configureAbbreviationLabel() {
    
        abbreviationLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        abbreviationLabel.textAlignment = .left
    }
    
    func configureCorporationNameLabel() {
        corporationNameLabel.font = UIFont(name: "Helvetica", size: 12)
        corporationNameLabel.adjustsFontSizeToFitWidth = false
        corporationNameLabel.minimumScaleFactor = 0.5
        corporationNameLabel.adjustsFontSizeToFitWidth = false
        corporationNameLabel.lineBreakMode = .byTruncatingTail
    }
    
    func configureStarImageView() {
        starImageView.image = UIImage(named: "star")
        starImageView.isHidden = true
    }
    
    func configureCurrentPriceLabel() {
        currentPriceLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        currentPriceLabel.textAlignment = .right
        currentPriceLabel.sizeToFit()
    }
    
    func configureDifferenceLabel() {
        differenceLabel.font = UIFont(name: "Helvetica", size: 12)
        differenceLabel.textAlignment = .right
        differenceLabel.sizeToFit()
    }
    
    func setLogoViewConstraint() {
        logoCompanyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoCompanyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoCompanyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logoCompanyImageView.heightAnchor.constraint(equalToConstant: 52),
            logoCompanyImageView.widthAnchor.constraint(equalTo: logoCompanyImageView.heightAnchor),
        ])
    }
    
    func setStarImageViewConstraints() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: abbreviationLabel.topAnchor, constant: 1),
            starImageView.leadingAnchor.constraint(equalTo: abbreviationLabel.trailingAnchor, constant: 6),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor),
        ])
    }
    func setAbbreviationLabelConstraint() {
        abbreviationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abbreviationLabel.leadingAnchor.constraint(equalTo: self.logoCompanyImageView.trailingAnchor, constant: 12),
            abbreviationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
        ])
    }
    func setCorporationNameLabelConstraint() {
        corporationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            corporationNameLabel.leadingAnchor.constraint(equalTo: self.abbreviationLabel.leadingAnchor),
            corporationNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.differenceLabel.leadingAnchor),
            corporationNameLabel.topAnchor.constraint(equalTo: self.abbreviationLabel.bottomAnchor)
        ])
        corporationNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
    
    func setCurrentPriceLabelConstraint() {
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            currentPriceLabel.topAnchor.constraint(equalTo: self.abbreviationLabel.topAnchor)
        ])
    }
    func setDiffernceConstraint() {
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

