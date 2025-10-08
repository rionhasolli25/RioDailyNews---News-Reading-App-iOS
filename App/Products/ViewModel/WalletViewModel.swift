//
//  Football.swift
//  RionApp.com
//
//  Created by Rion on 27.1.23.
//

import Foundation
protocol WalletViewDelegateProtocol : AnyObject{
    func showEditAccount()
    func openURLPage(url:String)
}
protocol MyWalletViewModelProtocol : BaseViewModel {
    var coordinateDelegate : WalletViewDelegateProtocol? {get set}
    var techNewsDataSource : TechNewsDataSource?{get}
    var healthDataSource : HealthDataSource? {get}
    func getProducts(completion : @escaping(((HealthNews?)) -> Void))
    func getTechNews (completion : @escaping(((TechNews?)) -> Void))
    func getTechNewsList(list: [TechNewsArticle]?)
    func getList(list : [HealthArticle]?)
}
class MyWalletViewModel: MyWalletViewModelProtocol  {
    
    var healthDataSource: HealthDataSource?
    var coordinateDelegate: WalletViewDelegateProtocol?
    var techNewsDataSource : TechNewsDataSource?
    
    init() {
        
        self.healthDataSource = HealthDataSource()
        self.healthDataSource?.delegate = self

        
    }
    func getList(list: [HealthArticle]?) {
        self.healthDataSource?.healtharticle = list
    }
    func getProducts(completion: @escaping (((HealthNews?)) -> Void)) {
        let auth = AuthenticationClient.getProducts()
        auth.execute(onSuccess: { response in
            completion(response)
        }, onFailure: { error in
            completion(nil)
        })
    }
        
        func getTechNews(completion: @escaping (((TechNews?)) -> Void)) {
            let auth = AuthenticationClient.getTechNews()
            auth.execute(onSuccess: { response in
                completion(response)
            }, onFailure: { error in
                completion(nil)
            })
        }
        func getTechNewsList(list: [TechNewsArticle]?) {
            self.techNewsDataSource?.technews = list
        }
  
    }

extension MyWalletViewModel : HealthDataSourceViewDelegate{
    func openWebPage(url: String) {
        self.coordinateDelegate?.openURLPage(url: url)
        print("ViewModel forwarding URL:", url)
    }
}
