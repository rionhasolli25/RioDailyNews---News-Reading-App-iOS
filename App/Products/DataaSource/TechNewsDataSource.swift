//
//  WalletDataSource.swift
//  RionApp.com
//
//  Created by Rion on 3.2.23.
//

import Foundation
import UIKit

protocol TechNewsDataSourceViewDelegate : AnyObject{
    func openPage(url:String)
}

class TechNewsDataSource : NSObject,UITableViewDataSource,UITableViewDelegate{
    
    var delegate : TechNewsDataSourceViewDelegate?
    
    var technews : [TechNewsArticle]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Rows count:", technews?.count ?? 0)
        return technews?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TechNewsTableViewCell.self, for: indexPath)
        if let techNewsArticle = technews?[indexPath.row]{
            cell.techNewsArticle = techNewsArticle
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = technews?[indexPath.row].url else {return}
        print("click")
        self.delegate?.openPage(url: url)
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
