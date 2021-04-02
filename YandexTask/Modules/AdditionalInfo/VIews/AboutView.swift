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
        //didTapContinue = handleContinue
        super.init(frame: .zero)
        setup()
    }
    func setup() {
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
            corpNameLable.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            corpNameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 98),
        ])
    }
    
    func setSectorOfCompanyConstraints() {
        sectorOfCompanyLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectorOfCompanyLable.topAnchor.constraint(equalTo: corpNameLable.bottomAnchor, constant: 28),
            sectorOfCompanyLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            sectorOfCompanyLable.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -28),
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
    }
    func configSectorOfCompanyLable() {
        sectorOfCompanyLable.font = UIFont(name: "Helvetica Bold", size: 24)
    }
    func configAboutCompanyLable() {
        aboutCompany.font = UIFont(name: "Helvetica", size: 14)
        aboutCompany.isEditable = false
    }
    func configPlaceAndPhoneLable() {
        placeAndPhoneLable.font = UIFont(name: "Helvetica", size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
