//
//  AppleNewsViewModel.swift
//  RioDailyNews
//
//  Created by Rion on 2.10.25.
//


protocol AppleNewsDelegateProtocol : AnyObject{
    func openURLPage(url:String)
}
protocol AppleNewsViewModelProtocol : BaseViewModel{
    var coordinateDelegate : AppleNewsDelegateProtocol? {get set}
    var appleNewsDataSource : AppleNewsDataSource? {get}
    func appleNews(completion : @escaping((LatestNews?)) -> Void)
    func AppleListnews(list:[LatestArticle]?)
}

class AppleNewsViewModel : AppleNewsViewModelProtocol{
    
    var coordinateDelegate:  AppleNewsDelegateProtocol?
    var appleNewsDataSource : AppleNewsDataSource?
    
    init(){
        appleNewsDataSource = AppleNewsDataSource()
        self.appleNewsDataSource?.delegate = self
    }
    
    func appleNews(completion: @escaping ((LatestNews?)) -> Void) {
        let auth = AuthenticationClient.getCollections()
        auth.execute(onSuccess: { response in
            completion(response)
        }, onFailure: { error in
            completion(nil)
        })
    }
    func AppleListnews(list: [LatestArticle]?) {
        self.appleNewsDataSource?.AppleNewsproducts = list
    }
}

extension AppleNewsViewModel : AppleNewsDataSourceProtocol{
    func openURLPage(url: String) {
        self.coordinateDelegate?.openURLPage(url: url)
        print("ViewModel forwarding URL:", url)
    }
}
