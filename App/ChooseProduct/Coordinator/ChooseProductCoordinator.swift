//
//  ChooseProductCoordinator.swift
//  RionApp.com
//
//  Created by Rion on 23.2.23.
//

import Foundation

class ChooseProductCoordinator : DefaultCoordinator{
    var viewController : ChooseProductViewController?
    var viewModel : ChooseProductViewModelProtocol?
 
    
    init(viewModel : ChooseProductViewModelProtocol = ChooseProductViewModel()) {
        self.viewModel = viewModel
        self.viewModel?.coordinateDelegate = self
    }
    func start() {
        self.viewController = ChooseProductViewController.instantiate(.chooseProduct)
        self.viewController?.viewModel = viewModel
    }
}
extension ChooseProductCoordinator : ChooseNewProductViewDelegate{
    func showProducts(id: Int) {
    }

}
