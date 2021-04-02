//
//  AddInfoViewController.swift
//  YandexTask
//
//  Created by Максим Сурков on 26.03.2021.
//

import Foundation
import UIKit
import TinyConstraints
import Kingfisher

class AddInfoViewController: UIViewController {
    
    var presenter: AddInfoPresenterProtocol!
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    var titleStackView = UIStackView()
    var tableView = UITableView()
    
    lazy var segmnetedControll : UISegmentedControl = {
        let controll = UISegmentedControl(items: presenter.getTitles())
        controll.selectedSegmentIndex = 0
        controll.backgroundColor = .clear
        return controll
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.setView()
        presenter.getNewsData()
        
        setupSegmentControl()
        navigationItem.titleView = titleStackView
        setupTableView()
    }
    override func viewWillLayoutSubviews() {
          super.viewWillLayoutSubviews()

          if view.traitCollection.horizontalSizeClass == .compact {
              titleStackView.axis = .vertical
              titleStackView.spacing = UIStackView.spacingUseDefault
          } else {
              titleStackView.axis = .horizontal
              titleStackView.spacing = 20.0
          }
      }
    private func setupSegmentControl(){
        view.addSubview(segmnetedControll)
        segmnetedControll.edgesToSuperview(excluding: .bottom,
                                           insets: UIEdgeInsets(top: 24, left: 20, bottom: 0, right: 20), usingSafeArea: true)
        segmnetedControll.height(30)
    }
    private func setupTableView() {
        view.addSubview(tableView)
        self.tableView.rowHeight = 400
        tableView.allowsSelection = false
        tableView.register(NewsCell.self, forCellReuseIdentifier: "news")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.canCancelContentTouches = false
        tableView.separatorStyle = .none
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmnetedControll.bottomAnchor, constant: 18),
            tableView.leadingAnchor.constraint(equalTo: segmnetedControll.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: segmnetedControll.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    private func updateView() {
            if segmnetedControll.selectedSegmentIndex == 0 {
                //remove(asChildViewController: secondViewController)
                //add(asChildViewController: firstViewController)
            } else if (segmnetedControll.selectedSegmentIndex == 1) {
//                remove(asChildViewController: firstViewController)
//                add(asChildViewController: secondViewController)
            }
    }
}
extension AddInfoViewController: AddInfoViewProtocol{
    func gotNews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func succes(model: ModelStock) {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 18)
        titleLabel.text = model.symbol
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = model.companyName
        subtitleLabel.font = UIFont(name: "Helvetica", size: 12)
        
        titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleStackView.axis = .vertical
        titleStackView.setCustomSpacing(4, after: titleLabel)
        
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func failure(error: Error) {
        print("ViewController: \(error.localizedDescription)")
    }
}
extension AddInfoViewController: UITableViewDelegate, UITableViewDataSource,  UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            UIApplication.shared.open(URL)
            return false
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getStorageCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "news", for:  indexPath) as!
        NewsCell
        cell.headLineLabel.text = presenter.storageNews?[indexPath.row].headline
        cell.summaryTextView.text = presenter.storageNews?[indexPath.row].summary
        let timeInterval = Double(presenter.storageNews?[indexPath.row].datetime ?? 1617273044000)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        
        let relatedText = (presenter.storageNews?[indexPath.row].source) ?? "No related"
        cell.sourceAndDataTimeLabel.text = relatedText + ", " + myNSDate.asString()
        
        let attributedString = NSAttributedString.makeHyperlink(for: presenter.storageNews?[indexPath.row].url ?? "", in: cell.urlTextView.text ?? "", as: "Article")
        cell.urlTextView.attributedText = attributedString
        
        cell.newsImageView.kf.indicatorType = .activity
        cell.newsImageView.kf.setImage(with: URL(string: presenter.storageNews?[indexPath.row].image ?? ""))
        return cell
    }
    
    
}


