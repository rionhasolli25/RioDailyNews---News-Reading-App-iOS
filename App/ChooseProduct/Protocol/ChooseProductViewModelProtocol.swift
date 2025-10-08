//
//  ChooseProductViewModelProtocol.swift
//  RionApp.com
//
//  Created by Rion on 23.2.23.
//

import Foundation


protocol ChooseProductViewModelProtocol : BaseViewModel{
    var ID: Int?{get}
    var coordinateDelegate : ChooseNewProductViewDelegate?{set get}
    var dataSource : ChooseProductsViewDataSource?{get}
    func getCarts(completion : @escaping((FakeStoreModelElement?)-> Void))
    func getImages(images : [Product]?)
    func showProducts(id:Int)
}
