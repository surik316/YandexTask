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
    var infoView = UIView()
    var headLineLabel = UILabel()
    var urlTextLabel = UILabel()
    var url: URL!
    var summaryTextView = UILabel()
    var sourceAndDataTimeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        contentView.addSubview(newsImageView)
        contentView.addSubview(headLineLabel)
        contentView.addSubview(infoView)
        setupNewsImageView()
        setupNewsImageViewConstraints()
        backgroundColor = Colors.backgroundColor
        setupStackView()
        setupStackViewConstraints()
        
    }
    func setupNewsImageView() {
        newsImageView.layer.cornerRadius = 27
        newsImageView.clipsToBounds  = true
    }
    func setupStackView() {
        infoView.layer.cornerRadius = 23
        infoView.backgroundColor = Colors.newsDescriptionColor
        infoView.addSubview(summaryTextView)
        infoView.addSubview(containerView)
        //summaryTextView.
        summaryTextView.numberOfLines = 0
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryTextView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 6),
            summaryTextView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -6),
            summaryTextView.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 6),
            summaryTextView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -35),

            containerView.leadingAnchor.constraint(equalTo: summaryTextView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: summaryTextView.bottomAnchor, constant: 10)



        ])
        
        urlTextLabel.font = UIFont(name: "Helvetica", size: 12)
        sourceAndDataTimeLabel.font = UIFont(name: "Helvetica", size: 12)
        headLineLabel.numberOfLines = 2
        headLineLabel.textColor = .white
        headLineLabel.font = UIFont(name: "Helvetica Bold", size: 14)
        headLineLabel.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        urlTextLabel.text = "Article"
        urlTextLabel.textColor = .white
        urlTextLabel.textAlignment = .center
        urlTextLabel.backgroundColor = .white
        urlTextLabel.isUserInteractionEnabled = true
        urlTextLabel.backgroundColor = Colors.newsDescriptionColor
        contentView.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        containerView.isUserInteractionEnabled = true
        summaryTextView.font = UIFont(name: "Helvetica", size: 14)
        let gestrure = UITapGestureRecognizer(target: self, action: #selector(taped))
        //summaryTextView.isEditable = false
        contentView.addGestureRecognizer(gestrure)
        setupContainerViewConstraints()
        
    }
    @objc func taped() {
        UIApplication.shared.openURL(self.url)
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
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 4),
            infoView.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setupContainerViewConstraints() {
        
        containerView.addSubview(urlTextLabel)
        containerView.addSubview(sourceAndDataTimeLabel)
        isUserInteractionEnabled = true
        sourceAndDataTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        urlTextLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            sourceAndDataTimeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            sourceAndDataTimeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            
            urlTextLabel.centerYAnchor.constraint(equalTo: sourceAndDataTimeLabel.centerYAnchor, constant: -2),
            urlTextLabel.leadingAnchor.constraint(equalTo: sourceAndDataTimeLabel.trailingAnchor, constant: 15),
            urlTextLabel.heightAnchor.constraint(equalToConstant: 25),
            urlTextLabel.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
