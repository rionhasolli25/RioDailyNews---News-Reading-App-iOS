//
//  ChooseProductViewModel.swift
//  RionApp.com
//
//  Created by Rion on 23.2.23.
//

import Foundation


class ChooseProductViewModel : ChooseProductViewModelProtocol{
    
    var ID: Int?
    var coordinateDelegate: ChooseNewProductViewDelegate?
    var dataSource: ChooseProductsViewDataSource?
    init(){
        dataSource = ChooseProductsViewDataSource()
    }
    func showProducts(id: Int) {
        self.coordinateDelegate?.showProducts(id: id)
    }
    func getImages(images: [Product]?) {
        
    }
    func getCarts(completion: @escaping ((FakeStoreModelElement?) -> Void)) {
    }
}
