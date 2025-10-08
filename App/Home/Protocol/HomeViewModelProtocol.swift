//
//  HomeViewModelProtocol.swift
//  NewsReadingApp
//
//  Created by Rion on 12.9.25.
//
import Foundation

protocol HomeViewModelProtocol: BaseViewModel{
    var viewDelegate:HomeViewModelViewDelegate?{get set}
    var dataSource : NewsDataSource?{get}
    var promotionDataSource : ProductDatsSource?{get}
    var coordinateDelegate : HomeViewProtocolDelegate?{get set}
    func getAppleNews(completion : @escaping(((AppleNews?)) -> Void))
    func getAlbums(completion: @escaping (((LatestNews?)) -> Void))
    func getAlbumsList(list: [LatestArticle]?)
    func getAppleNewslist(list : [AppleArticle]?)
    func showMandate()
}
