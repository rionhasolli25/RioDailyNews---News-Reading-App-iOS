//
//  HomeViewModel.swift
//  NewsReadingApp
//
//  Created by Rion on 12.9.25.
//

import Foundation

protocol HomeViewModelViewDelegate : AnyObject{
    func diaplayPageindex()
    func openWebPage(url:String)
}
class HomeViewModel:HomeViewModelProtocol{
    
    var dataSource: NewsDataSource?
    var promotionDataSource: ProductDatsSource?
    var coordinateDelegate: HomeViewProtocolDelegate?
    var viewDelegate : HomeViewModelViewDelegate?

    
    init(){
        dataSource = NewsDataSource()
        promotionDataSource = ProductDatsSource()
        self.dataSource?.delegate = self
        self.promotionDataSource?.delegate = self
    }
    func getAppleNewslist(list: [AppleArticle]?) {
        self.dataSource?.appleNews = list
    }
    func getAlbumsList(list: [LatestArticle]?){
        self.promotionDataSource?.latestNews = list
    }
    func navigateToSportNews() {
        coordinateDelegate?.navigateToSportNews()
    }
    func getAppleNews(completion: @escaping (((AppleNews?)) -> Void)) {
        let auth = AuthenticationClient.getAppleNews()
        auth.execute(onSuccess: { response in
            completion(response)
        }, onFailure: { error in
            completion(nil)
        })
    }
    func getAlbums(completion: @escaping (((LatestNews?)) -> Void)) {
        let auth = AuthenticationClient.getAlbums()
        auth.execute(onSuccess: { response in
            completion(response)
        }, onFailure: { error in
            completion(nil)
        })
    }
    func showMandate(){
        coordinateDelegate?.navigateToMandate()
    }
    
}

extension HomeViewModel : NewsDataSourceProtocol{
    func openWebPage(url: String) {
        self.viewDelegate?.openWebPage(url: url)
    }
}
extension HomeViewModel: ProductDataSourceProtocol{
    func displayPageIndex() {
        
    }
    
    func navigateToMandate() {
        
    }
}
