//
//  USNewsViewModel.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//

import Foundation

class USNewsViewModel : USNewsViewModelProtocol{
   
    
    var usnewsdataSource: USNewsDataSource?
    var coordinateDelegate: USNewsViewDelegate?
    
    init(){
        usnewsdataSource = USNewsDataSource()
        self.usnewsdataSource?.delegate = self
    }
    func showNews(url: String) {
        
    }
    
    func getUSNews(completion: @escaping (((USANewsModel?)) -> Void)) {
        let auth = AuthenticationClient.getUSANews()
        auth.execute(onSuccess: { response in
            completion(response)
        }, onFailure: { error in
            completion(nil)
        })
    }
    
    func getUSNewsList(list: [USAArticle]?) {
        self.usnewsdataSource?.usArticle = list
    }
    
}
extension USNewsViewModel : USNewsDataSourceProtocol{
    func openURL(url: String) {
        self.coordinateDelegate?.showURL(url: url)
    }
}
