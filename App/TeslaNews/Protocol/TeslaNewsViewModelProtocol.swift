//
//  TeslaNewsViewModelProtocol.swift
//  RioDailyNews
//
//  Created by Rion on 21.9.25.
//

protocol TeslaNewsViewModelProtocol: BaseViewModel{
    var coordinateDelegate: TeslaNewsViewProtocolDelegate? {get set}
    var viewDelegate : TeslaNewsListViewModelViewDelagate?{get set}
    var teslaDataSource: TeslaNewsDataSource? {get set}
    func getTeslaList(list:[TeslaArticle]?)
    func getTeslatNews(completion : @escaping((Tesla?) -> Void))
}
