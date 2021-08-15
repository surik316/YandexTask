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
    let headerView = ListTableViewHeader()
    let tableView = UITableView()
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
        setupTableView()
        setupHeaderView()
        setupSearchController()
        presenter.load()
    }
    @objc func refresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        presenter.load()
    }
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find company or ticker"
        definesPresentationContext = true
    }
    
//    private func loadStocksData() {
//            presenter.getStockData{ [weak self] in
//                self?.tableView.dataSource = self
//                self?.tableView.reloadData()
//            }
//    }
    
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
        tableView.backgroundColor = Colors.backgroundColor
    }
    
    func setupHeaderView(){
        let tapStockHeader = UITapGestureRecognizer(target: self, action:
                                                        #selector(ListViewController.stockLabelTapped))
        headerView.headerStock.addGestureRecognizer(tapStockHeader)
        let tapFavouriteHeader = UITapGestureRecognizer(target: self, action: #selector(ListViewController.favouriteLabelTapped))
        headerView.headerFavourite.addGestureRecognizer(tapFavouriteHeader)
    }
    
    private func filterStocks(for searchText: String) {
        if presenter.isLableTappedFavourite{
            presenter.filterStorageStocks(searchText: searchText)
        }
        else{
            presenter.filterStorageStocks(searchText: searchText)
        }
      tableView.reloadData()
    }
    func starTapped(cell: CustomCell) {
        HapticsManager.shared.selectionVibrate()
        if !cell.isFavourite && !presenter.isLableTappedFavourite{
            cell.buttonStar.setImage(UIImage(named: "star"), for: .normal)
            cell.isFavourite = true
            presenter.storageStocks[cell.tag].isFavourite = true
            presenter.storageLikedStocks.append(presenter.storageStocks[cell.tag])
            
        } else {
            
            
            cell.buttonStar.setImage(UIImage(named: "emptyStar"), for: .normal)
            cell.isFavourite = false
            if let index = presenter.storageLikedStocks.firstIndex(where: {$0.companyName == cell.corporationNameLabel.text}){
                if let bumber = presenter.storageStocks.firstIndex(where: {$0.companyName == cell.corporationNameLabel.text}) {
                    
                    presenter.storageStocks[bumber].isFavourite = false
                }
                presenter.storageLikedStocks.remove(at: index)
                
            }
            if presenter.isLableTappedFavourite {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            

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
        presenter.changeStateLableFavourite(state: false)
        setToDefaultLabelConfig(label: headerView.headerFavourite)
        setToSelectedLabel(label: headerView.headerStock)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @objc func favouriteLabelTapped(sender: UITapGestureRecognizer) {
        
        presenter.changeStateLableFavourite(state: true)
        setToDefaultLabelConfig(label: headerView.headerStock)
        setToSelectedLabel(label: headerView.headerFavourite)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListViewController: ListViewProtocol{
    func sucess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure(error: Error) {
        print("ViewController: \(error.localizedDescription)")
    }
}
