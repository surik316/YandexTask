//
//  AboutView.swift
//  YandexTask
//
//  Created by Максим Сурков on 02.04.2021.
//

import Foundation
import UIKit

class AboutView: UIView {
    
    var corpNameLable = UILabel()
    var sectorOfCompanyLable = UILabel()
    var aboutCompany = UITextView()
    var placeAndPhoneLable = UILabel()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    func setup() {
        aboutCompany.backgroundColor = Colors.backgroundColor
        addSubview(corpNameLable)
        addSubview(sectorOfCompanyLable)
        addSubview(aboutCompany)
        addSubview(placeAndPhoneLable)
        
        setCorpNameLableConstraints()
        setSectorOfCompanyConstraints()
        setAboutCompanyConstraints()
        setPlaceAndPhoneConstraints()
        
        configCorpNameLable()
        configSectorOfCompanyLable()
        configAboutCompanyLable()
        configPlaceAndPhoneLable()
    }
    
    func setCorpNameLableConstraints() {
        corpNameLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            corpNameLable.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            corpNameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 98),
            corpNameLable.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -98),
        ])
    }
    
    func setSectorOfCompanyConstraints() {
        sectorOfCompanyLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectorOfCompanyLable.topAnchor.constraint(equalTo: corpNameLable.bottomAnchor, constant: 28),
            sectorOfCompanyLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            sectorOfCompanyLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 56)
        ])
    }
    
    func setAboutCompanyConstraints() {
        aboutCompany.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutCompany.topAnchor.constraint(equalTo: sectorOfCompanyLable.bottomAnchor, constant: 40),
            aboutCompany.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            aboutCompany.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -20),
            aboutCompany.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -96)
        ])
    }
    func setPlaceAndPhoneConstraints() {
        placeAndPhoneLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeAndPhoneLable.topAnchor.constraint(equalTo: aboutCompany.bottomAnchor, constant: 67),
            placeAndPhoneLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 47),
            placeAndPhoneLable.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -47),
        ])
    }
    
    func configCorpNameLable() {
        corpNameLable.font = UIFont(name: "Helvetica Bold", size: 36)
        corpNameLable.numberOfLines = 2
        corpNameLable.minimumScaleFactor = 0.5
        corpNameLable.adjustsFontSizeToFitWidth = true
        corpNameLable.textAlignment = .center
    }
    func configSectorOfCompanyLable() {
        sectorOfCompanyLable.font = UIFont(name: "Helvetica Bold", size: 24)
        sectorOfCompanyLable.numberOfLines = 2
        sectorOfCompanyLable.textAlignment = .center
        sectorOfCompanyLable.minimumScaleFactor = 0.5
        sectorOfCompanyLable.adjustsFontSizeToFitWidth = true
    }
    func configAboutCompanyLable() {
        aboutCompany.font = UIFont(name: "Helvetica", size: 14)
        aboutCompany.isEditable = false
    }
    func configPlaceAndPhoneLable() {
        placeAndPhoneLable.font = UIFont(name: "Helvetica", size: 14)
        placeAndPhoneLable.minimumScaleFactor = 0.5
        placeAndPhoneLable.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
