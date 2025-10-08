//
//  NewProfileViewModelProtocol.swift
//  RionApp.com
//
//  Created by Rion on 25.1.23.
//

import Foundation


protocol NewProfileViewModelProtocol : BaseViewModel{
    var coordinateDelegate: NewProfileProtocolViewDelegate? {get set}
    var techNewsDataSource : TechNewsDataSource?{get set}
    func getTechNews (completion : @escaping(((TechNews?)) -> Void))
    func getTechNewsList(list: [TechNewsArticle]?)
}
