////
////  LIstViewTableViewDelegate.swift
////  YandexTask
////
////  Created by Максим Сурков on 03.07.2021.
////
//
//import Foundation
import UIKit
class LIstViewTableViewDelegate: NSObject,UITableViewDelegate {
    weak var presenter: ListPresenter!
    var viewController: ListViewController?
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    init(view: ListViewController) {
         viewController = view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var model: ModelStock
        if ((viewController?.isLableTappedFavourite) != nil) {
            model = presenter.storageLikedStocks[indexPath.row]
        }
        else {
            model = presenter.storageStocks[indexPath.row]
        }
        let viewController = ListBuilder.createAddInfoModule(modelStock: model)
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
        headerView.backgroundColor = viewController?.view.backgroundColor
            return headerView
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}
