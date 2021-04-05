//
//  NewsView.swift
//  YandexTask
//
//  Created by Максим Сурков on 31.03.2021.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    
    var  newsImageView = UIImageView()
    var imageNews: UIImage?
    var containerView = UIView()
    var stackView = UIStackView()
    var headLineLabel = UILabel()
    var urlTextView = UITextView()
    var summaryTextView = UITextView()
    var sourceAndDataTimeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(headLineLabel)
        contentView.addSubview(stackView)
        setupNewsImageView()
        setupNewsImageViewConstraints()
        
        setupStackView()
        setupStackViewConstraints()
        
    }
    func setupNewsImageView() {
        newsImageView.layer.cornerRadius = 27
        newsImageView.clipsToBounds  = true
    }
    func setupStackView() {
        
        stackView.layer.cornerRadius = 23
        stackView.clipsToBounds  = true
        summaryTextView.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
        containerView.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
        
        urlTextView.font = UIFont(name: "Helvetica", size: 12)
        sourceAndDataTimeLabel.font = UIFont(name: "Helvetica", size: 12)
        headLineLabel.numberOfLines = 2
        headLineLabel.textColor = .white
        headLineLabel.font = UIFont(name: "Helvetica Bold", size: 14)
        headLineLabel.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        urlTextView.text = "Article"
        urlTextView.textColor = .black
        urlTextView.textAlignment = .center
        urlTextView.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
        urlTextView.isScrollEnabled = false
        
        summaryTextView.font = UIFont(name: "Helvetica", size: 14)
        summaryTextView.isEditable = false
        stackView.addArrangedSubview(summaryTextView)
        stackView.addArrangedSubview(containerView)
        setupContainerViewConstraints()
        
    }
    func setupNewsImageViewConstraints() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        headLineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            headLineLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -55),
            headLineLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: 12),
            headLineLabel.trailingAnchor.constraint(lessThanOrEqualTo: newsImageView.trailingAnchor, constant: -12)
           
        ])
    }
    func setupStackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 7),
            stackView.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setupContainerViewConstraints() {
        
        containerView.addSubview(urlTextView)
        containerView.addSubview(sourceAndDataTimeLabel)
        
        sourceAndDataTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        urlTextView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            sourceAndDataTimeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            sourceAndDataTimeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            
            urlTextView.topAnchor.constraint(equalTo: sourceAndDataTimeLabel.topAnchor),
            urlTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            urlTextView.heightAnchor.constraint(equalToConstant: 25),
            urlTextView.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
