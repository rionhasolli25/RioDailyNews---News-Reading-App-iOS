//
//  NewProfileViewModel.swift
//  RionApp.com
//
//  Created by Rion on 25.1.23.
//

import Foundation


protocol TechNewsViewModelProtocolViewDelegate : AnyObject{
    func openURLPage(url:String)
}

protocol TechNewsViewModelProtocol : BaseViewModel {
    
    var coordinateDelegate : TechNewsViewModelProtocolViewDelegate? {get set}
    var techNewsDataSource: TechNewsDataSource? { get}

    func getTechNews (completion : @escaping(((TechNews?)) -> Void))
    func getTechNewsList(list: [TechNewsArticle]?)

}
class TechNewsViewModel: TechNewsViewModelProtocol{

    
    var coordinateDelegate: TechNewsViewModelProtocolViewDelegate?
    var techNewsDataSource : TechNewsDataSource?
    
    init() {
        
        self.techNewsDataSource = TechNewsDataSource()
        self.techNewsDataSource?.delegate = self
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

extension TechNewsViewModel : TechNewsDataSourceViewDelegate{
    func openPage(url: String) {
        self.coordinateDelegate?.openURLPage(url: url)
        print("ViewModel forwarding URL:", url)
    }
}


//protocol NewProfileViewModelViewDelegate : AnyObject{
//    func openUrl(url:String)
//}
//class NewProfileViewModel : NewProfileViewModelProtocol{
//
//    var coordinateDelegate:NewProfileViewModelViewDelegate?
//    var techNewsDataSource: TechNewsDataSource?
//
//    init(){
//        techNewsDataSource = TechNewsDataSource()
//        self.techNewsDataSource?.delegate = self
//    }
//    func getTechNews(completion: @escaping (((TechNews?)) -> Void)) {
//        let auth = AuthenticationClient.getTechNews()
//        auth.execute(onSuccess: { response in
//            completion(response)
//        }, onFailure: { error in
//            completion(nil)
//        })
//    }
//    func getTechNewsList(list: [TechNewsArticle]?) {
//        self.techNewsDataSource?.technews = list
//
//
//    }
//}
//
//extension NewProfileViewModel : TechNewsDataSourceViewDelegate{
//    func openPage(url: String) {
//        self.coordinateDelegate?.openUrl(url: url)
//        print("ViewModel forwarding URL:", url)
//    }
//
//
//}
