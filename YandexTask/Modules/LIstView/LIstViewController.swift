//
//  LIstViewController.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import UIKit
import Kingfisher

class ListViewController: UIViewController, UISearchBarDelegate{
    
    var presenter: ListViewPresenterProtocol!
    let searchController = UISearchController(searchResultsController: nil)
    private let headerView = ListTableViewHeader()
    var tableView = UITableView()
    var isLableTappedFavourite = false
    var filteredStocks: [ModelStock]?
    private let refreshControl = UIRefreshControl()
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        loadStocksData()
        setupTableView()
        setupHeaderView()
        setupSearchController()
    }
    @objc func refresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        loadStocksData()
    }
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find company or ticker"
        definesPresentationContext = true
    }
    
    private func loadStocksData() {
            presenter.fetchStockData{ [weak self] in
                self?.tableView.dataSource = self
                self?.tableView.reloadData()
            }
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  68.0
        tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupHeaderView(){
        let tapStockHeader = UITapGestureRecognizer(target: self, action:
                                                        #selector(ListViewController.stockLabelTapped))
        headerView.headerStock.addGestureRecognizer(tapStockHeader)
        let tapFavouriteHeader = UITapGestureRecognizer(target: self, action: #selector(ListViewController.favouriteLabelTapped))
        headerView.headerFavourite.addGestureRecognizer(tapFavouriteHeader)
    }
    
    private func filterStocks(for searchText: String) {
        if isLableTappedFavourite{
            filteredStocks = presenter.storageLikedStocks.filter { stock in
                return stock.symbol.lowercased().contains(searchText.lowercased()) || stock.companyName.lowercased().contains(searchText.lowercased())
            }
        }
        else{
            filteredStocks = presenter.storageStocks.filter { stock in
                return stock.symbol.lowercased().contains(searchText.lowercased()) || stock.companyName.lowercased().contains(searchText.lowercased())
            }
        }
      tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering && searchController.searchBar.text != ""{
            return filteredStocks?.count ?? 0
        }
        else if (presenter.storageStocks.count != 0){
            if isLableTappedFavourite {
                return presenter.storageLikedStocks.count
            }
            return presenter.storageStocks.count
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var model: ModelStock
        if (isLableTappedFavourite) {
            model = presenter.storageLikedStocks[indexPath.row]
        }
        else {
            model = presenter.storageStocks[indexPath.row]
        }
        let viewController = ListBuilder.createAddInfoModule(modelStock: model)
        navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom", for:  indexPath) as!
        CustomCell
        
        var stock: ModelStock?
        if isFiltering {
            stock = filteredStocks?[indexPath.row]
        }
        else {
            if !isLableTappedFavourite{
                stock = presenter.storageStocks[indexPath.row]
            }
            else {
                stock = presenter.storageLikedStocks[indexPath.row]
            }
        }
        presenter.fetchStocksImage(symbol: (stock?.symbol)!) { (result) in
            switch result{
            case .success(let url):
                DispatchQueue.main.async {
                    cell.logoCompanyImageView.kf.setImage(with: url)
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
        cell.tag = indexPath.row
        cell.buttonStar.addTarget(cell, action: #selector(cell.starButtonClick), for: .touchUpInside)
        cell.tapDelegate = self
        cell.abbreviationLabel.text = stock?.symbol
        cell.corporationNameLabel.text = stock?.companyName
        cell.currentPriceLabel.text = "$" + String(format: "%.2f", stock?.latestPrice ?? 0)
        let change = String(format: "%.2f", abs((stock?.iexClose ?? 0) - (stock?.previousClose ?? 0)))
        let mod_iexClose = (stock?.iexClose ?? 0).truncatingRemainder(dividingBy: (stock?.previousClose ?? 0))
        let percentage = String(format: "%.2f", abs( mod_iexClose / (stock?.previousClose ?? 0)))
        if stock?.iexClose ?? 0 > stock?.previousClose ?? 0{
            cell.differenceLabel.text = "+$" + change + "(" + percentage + "%" + ")"
            cell.differenceLabel.textColor = UIColor.rgba(36, 178, 93)
        }
        else{
            cell.differenceLabel.text = "-$" + change + "(" + percentage + "%" + ")"
            cell.differenceLabel.textColor = UIColor.rgba(178, 36, 36)
        }
        cell.layer.cornerRadius = 16
        cell.backgroundColor = indexPath.row % 2 == 0 ? Colors.evenCellColor : Colors.oddCellColor
        return cell
    }
    func starTapped(cell: CustomCell) {
        HapticsManager.shared.selectionVibrate()
        if !cell.isFavourite {
            cell.buttonStar.setImage(UIImage(named: "star"), for: .normal)
            cell.isFavourite = true
        } else {
            cell.buttonStar.setImage(UIImage(named: "emptyStar"), for: .normal)
            cell.isFavourite = false

        }
    }
}
extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterStocks(for: searchController.searchBar.text ?? "")
    }
    
}
extension ListViewController{
    
    func setToSelectedLabel(label: UILabel){
        label.font = UIFont(name: "Helvetica Bold", size: 28)
        label.textColor = Colors.selectedLabelColor
    }
    func setToDefaultLabelConfig(label: UILabel){
        label.font = UIFont(name: "Helvetica Bold", size: 18)
        label.textColor = Colors.unselectedLabelColor
    }
    
    @objc func stockLabelTapped(sender:UITapGestureRecognizer) {
        isLableTappedFavourite = false
        setToDefaultLabelConfig(label: headerView.headerFavourite)
        setToSelectedLabel(label: headerView.headerStock)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @objc func favouriteLabelTapped(sender: UITapGestureRecognizer) {
        
            
        isLableTappedFavourite = true
        setToDefaultLabelConfig(label: headerView.headerStock)
        setToSelectedLabel(label: headerView.headerFavourite)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListViewController: ListViewProtocol{
    func succes() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure(error: Error) {
        print("ViewController: \(error.localizedDescription)")
    }
}
