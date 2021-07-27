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
    var aboutView = AboutView()
    var previousDayView = PreviousDayView()
    var chartView = ChartView()
    lazy var segmnetedControll : UISegmentedControl = {
        let controll = UISegmentedControl(items: presenter.getTitles())
        controll.selectedSegmentIndex = 0
        controll.backgroundColor = .clear
        return controll
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor 
        presenter.setView()
        presenter.getNewsData()
        presenter.getAboutCompanyData()
        presenter.getPreviousDayData()
        navigationItem.titleView = titleStackView
        
        setupSegmentControl()
        setupTableView()
        setupAboutView()
        setupPreviousDayView()
        setupChartView()
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
        segmnetedControll.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmnetedControll.height(30)
    }
    private func setupChartView() {
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartView.topAnchor.constraint(equalTo: segmnetedControll.bottomAnchor, constant: 3),
            chartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        chartView.isHidden = true
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
    
    private func setupAboutView() {
        view.addSubview(aboutView)
        aboutView.isHidden = true
        setupAboutViewConstraints()
    }
    private func setupPreviousDayView() {
        view.addSubview(previousDayView)
        previousDayView.isHidden = true
        setupPreviousDayConstraint()
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
    
    private func setupAboutViewConstraints() {
        aboutView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutView.topAnchor.constraint(equalTo: segmnetedControll.bottomAnchor, constant: 18),
            aboutView.leadingAnchor.constraint(equalTo: segmnetedControll.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: segmnetedControll.trailingAnchor),
            aboutView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    func setupPreviousDayConstraint() {
        previousDayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previousDayView.topAnchor.constraint(equalTo: segmnetedControll.bottomAnchor, constant: 18),
            previousDayView.leadingAnchor.constraint(equalTo: segmnetedControll.leadingAnchor),
            previousDayView.trailingAnchor.constraint(equalTo: segmnetedControll.trailingAnchor),
            previousDayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48)
            
        ])
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            tableView.isHidden = false
            aboutView.isHidden = true
            previousDayView.isHidden = true
            chartView.isHidden = true
        case 1:
            tableView.isHidden = true
            aboutView.isHidden = false
            previousDayView.isHidden = true
            chartView.isHidden = true
        case 2:
            tableView.isHidden = true
            aboutView.isHidden = true
            previousDayView.isHidden = false
            chartView.isHidden = true
        case 3:
            tableView.isHidden = true
            aboutView.isHidden = true
            previousDayView.isHidden = true
            chartView.isHidden = false
        default:
            print("Other index")
        }
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
        let timeInterval = Double(presenter.storageNews?[indexPath.row].datetime ?? 0)
        let myNSDate = Date(timeIntervalSince1970: timeInterval/1000)
        let relatedText = (presenter.storageNews?[indexPath.row].source) ?? "No related"
        cell.sourceAndDataTimeLabel.text = relatedText + ", " + myNSDate.asString()
        
        let attributedString = NSAttributedString.makeHyperlink(for: presenter.storageNews?[indexPath.row].url ?? "", in: cell.urlTextView.text ?? "", as: "Article")
        cell.urlTextView.attributedText = attributedString
        
        cell.newsImageView.kf.indicatorType = .activity
        cell.newsImageView.kf.setImage(with: URL(string: presenter.storageNews?[indexPath.row].image ?? ""), placeholder: UIImage(named: "bnImage"))
        return cell
    }
}
extension AddInfoViewController: AddInfoViewProtocol{
    func gotPreviousDay() {
        DispatchQueue.main.async {
            self.previousDayView.closePriceLabel.text = "$ " + String(self.presenter.storagePreviousDay?.closePrice ?? 0)
            self.previousDayView.highestPriceLabel.text = "$ " + String(self.presenter.storagePreviousDay?.highPrice ?? 0)
            self.previousDayView.lowestPriceLabel.text = "$ " + String(self.presenter.storagePreviousDay?.lowPrice ?? 0)
            self.previousDayView.openPriceLabel.text = "$ " + String(self.presenter.storagePreviousDay?.openPrice ?? 0)
        }
    }
    
    func gotAbout() {
        DispatchQueue.main.async {
            self.aboutView.corpNameLable.text = self.presenter.storageAbout?.companyName
            
            self.aboutView.sectorOfCompanyLable.text = self.presenter.storageAbout?.industry
            self.aboutView.aboutCompany.text = self.presenter.storageAbout?.description
            let country = (self.presenter.storageAbout?.country ?? "Country") + ", "
            let state = (self.presenter.storageAbout?.state ?? "State") + ", "
            let adress = (self.presenter.storageAbout?.address ?? "Adress") + ", "
            let phone = self.presenter.storageAbout?.phone ?? "88005553535"
            self.aboutView.placeAndPhoneLable.text = country + state + adress + phone
            
        }
    }
    
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
        print("ViewController addInfo: \(error.localizedDescription)")
    }
}


