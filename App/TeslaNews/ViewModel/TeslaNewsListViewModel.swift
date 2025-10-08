//
//  TeslaNewsListViewModel.swift
//  RioDailyNews
//
//  Created by Rion on 21.9.25.
//


import Foundation

protocol TeslaNewsListViewModelViewDelagate : AnyObject{
  func openWebPage(url:String)
}

class TeslaNewsListViewModel: TeslaNewsViewModelProtocol{
 
    var viewDelegate:  TeslaNewsListViewModelViewDelagate?
    var teslaDataSource: TeslaNewsDataSource?
    var coordinateDelegate:  TeslaNewsViewProtocolDelegate?
    
    init(){
        teslaDataSource = TeslaNewsDataSource()
        teslaDataSource?.delegate = self
    }
    
    func getTeslaList(list: [TeslaArticle]?) {
        self.teslaDataSource?.teslaNews = list
    }
    func protocoldelegate() {
        self.coordinateDelegate?.protocoldelegate()
    }
    func getTeslatNews(completion: @escaping ((Tesla?) -> Void)) {
        let auth = AuthenticationClient.getTeslaNews()
        auth.execute(onSuccess: { response in
            completion(response)
        }, onFailure: { error in
            completion(nil)
        })
    }
    
}

extension TeslaNewsListViewModel : TeslaNewsDataSourceViewDelegate{
    func openWebPage(url: String) {
        self.viewDelegate?.openWebPage(url: url)
    }

}
