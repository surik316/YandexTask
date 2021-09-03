//
//  LIstViewTableViewDelegate.swift
//  YandexTask
//
//  Created by Максим Сурков on 03.07.2021.
//
//
import Foundation
import UIKit
extension ListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var model: ModelStock
        if presenter.isLableTappedFavourite {
            model = presenter.storageLikedStocks[indexPath.row]
        } else {
            model = presenter.storageStocks[indexPath.row]
        }
        model.tag = indexPath.row
        let viewController = ListBuilder.createAddInfoModule(modelStock: model)
        navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
