//
//  USNewsViewModelProtocol.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//

protocol USNewsViewModelProtocol : BaseViewModel{
    var coordinateDelegate : USNewsViewDelegate?{ get set}
    var usnewsdataSource : USNewsDataSource? {get}
    func getUSNews (completion : @escaping(((USANewsModel?)) -> Void))
    func getUSNewsList(list: [USAArticle]?)
    func showNews(url:String)
}
