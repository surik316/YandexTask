//
//  AddInfoViewController.swift
//  YandexTask
//
//  Created by Максим Сурков on 26.03.2021.
//

import Foundation
import UIKit

class AddInfoViewController: UIViewController{
    
    var presenter: AddInfoPresenterProtocol!
    
    override func viewDidLoad() {
        self.viewDidLoad()
    }
}
extension AddInfoViewController: AddInfoViewProtocol{
    func succes(){
        
    }
    
    func failure(error: Error) {
        print("ViewController: \(error.localizedDescription)")
    }
}
