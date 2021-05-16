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
    private let searchController = UISearchController(searchResultsController: nil)
    private let headerStock = UILabel()
    private let headerFavourite = UILabel()
    var tableView = UITableView()
    var isLableTappedFavourite = false
    var filteredStocks: [ModelStock]?
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UserDefaults.standard.setValue("pk_5e1cf781419e4cc79ccf56075a4cbf6f", forKey: "apiToken")
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        
        loadStocksData()
        setupTableView()
        setupHeaders()
        setupSearchController()
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),//верх
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), //лево
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16), // право
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)//низ
        ])
    }
    
    func setupHeaders(){
        
        view.addSubview(headerStock)
        view.addSubview(headerFavourite)
        headerStock.translatesAutoresizingMaskIntoConstraints = false
        headerStock.text = "Stocks"
        headerStock.font = UIFont(name: "Helvetica-Bold", size: 28)
        headerStock.isUserInteractionEnabled = true
        let tapStockHeader = UITapGestureRecognizer(target: self, action:
                                                        #selector(ListViewController.stockLabelTapped))
        headerStock.addGestureRecognizer(tapStockHeader)
        
        headerFavourite.translatesAutoresizingMaskIntoConstraints = false
        headerFavourite.text = "Favourite"
        headerFavourite.font = UIFont(name: "Helvetica Bold", size: 18)
        headerFavourite.textColor = .systemGray3
        headerFavourite.isUserInteractionEnabled = true
        let tapFavouriteHeader = UITapGestureRecognizer(target: self, action: #selector(ListViewController.favouriteLabelTapped))
        headerFavourite.addGestureRecognizer(tapFavouriteHeader)
        
        NSLayoutConstraint.activate([
            headerStock.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 4),
            headerStock.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            
            headerFavourite.leadingAnchor.constraint(equalTo: headerStock.trailingAnchor, constant: 20),
            headerFavourite.bottomAnchor.constraint(equalTo: headerStock.bottomAnchor),
            
        ])
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
            let headerView = UIView()
            headerView.backgroundColor = view.backgroundColor
            return headerView
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAddFavourite = UIContextualAction(style: .normal, title: "Добавить") { (action, view, completion) in
            if (!constist(arrayStocks: self.presenter.storageLikedStocks, stock: self.presenter.storageStocks[indexPath.row]) && !self.isLableTappedFavourite){
                self.presenter.storageStocks[indexPath.row].isFavourite = true
                self.presenter.storageLikedStocks.append(self.presenter.storageStocks[indexPath.row])
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        swipeAddFavourite.image = UIImage(systemName: "hand.thumbsup.fill")
        swipeAddFavourite.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [swipeAddFavourite])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeDeleteFavourite = UIContextualAction(style: .normal, title: "удалить") { (action, view, completion) in
                if self.isLableTappedFavourite {
                    change_isFavourite(arrayStocks: &self.presenter.storageStocks, stock: self.presenter.storageLikedStocks[indexPath.row])
                    //self.presenter.storageStocks[indexPath.row].isFavourite = false
                    YandexTask.delete(arrayStocks: &self.presenter.storageLikedStocks, stock:  self.presenter.storageLikedStocks[indexPath.row])
                        
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                }
                }
                else{
                    self.presenter.storageStocks[indexPath.row].isFavourite = false
                    tableView.reloadRows(at: [indexPath], with: .fade)
                    YandexTask.delete(arrayStocks: &self.presenter.storageLikedStocks, stock:  self.presenter.storageStocks[indexPath.row])
                }
        }
        swipeDeleteFavourite.image = UIImage(systemName: "delete.left.fill")
        swipeDeleteFavourite.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [swipeDeleteFavourite])
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
        presenter.fetchStocksImage(symbol: stock?.symbol ?? "BOWX") { (result) in
            switch result{
            case .success(let url):
                DispatchQueue.main.async {
                    cell.logoCompanyImageView.kf.setImage(with: url)
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
        //print(stock?.isFavourite)
        cell.starImageView.isHidden = !(stock?.isFavourite ?? false)
        cell.abbreviationLabel.text = stock?.symbol
        cell.corporationNameLabel.text = stock?.companyName
        cell.currentPriceLabel.text = "$"+String(format: "%.2f", stock?.latestPrice ?? 0)
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
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.rgba(240, 244, 247) : .white
        return cell
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
        label.textColor = .black
        label.transform = label.transform.scaledBy(x: 0.35, y: 0.35)
        UIView.animate(withDuration: 0.5) {
             label.transform = CGAffineTransform(scaleX: 1, y: 1)
         }
    }
    func setToDefaultLabelConfig(label: UILabel){
        label.font = UIFont(name: "Helvetica Bold", size: 18)
        label.textColor = .systemGray3
    }
    
    @objc
        func stockLabelTapped(sender:UITapGestureRecognizer) {
            isLableTappedFavourite = false
            setToDefaultLabelConfig(label: headerFavourite)
            setToSelectedLabel(label: headerStock)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    @objc
        func favouriteLabelTapped(sender: UITapGestureRecognizer) {
            
            isLableTappedFavourite = true
            setToDefaultLabelConfig(label: headerStock)
            setToSelectedLabel(label: headerFavourite)
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
