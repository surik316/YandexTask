//
//  ListViewTableViewDataSource.swift
//  YandexTask
//
//  Created by Максим Сурков on 17.07.2021.
//

import Foundation
import UIKit
class ListViewTableViewDataSource: NSObject, UITableViewDataSource {
    weak var presenter: ListPresenter!
    weak var viewController: ListViewController!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewController.isFiltering && viewController.searchController.searchBar.text != ""{
            return viewController.filteredStocks?.count ?? 0
        }
        else if (presenter.storageStocks.count != 0){
            if viewController.isLableTappedFavourite {
                return presenter.storageLikedStocks.count
            }
            return presenter.storageStocks.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom", for:  indexPath) as!
        CustomCell
        
        var stock: ModelStock?
        if viewController.isFiltering {
            stock = presenter.filteredStocks?[indexPath.row]
        }
        else {
            if !viewController.isLableTappedFavourite{
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
        cell.tag = indexPath.row
        cell.buttonStar.addTarget(cell, action: #selector(cell.starButtonClick), for: .touchUpInside)
        cell.tapDelegate = viewController
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
}
