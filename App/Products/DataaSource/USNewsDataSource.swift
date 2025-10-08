//
//  USNewsDataSource.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//

import UIKit

protocol USNewsDataSourceProtocol : AnyObject{
    func openURL(url:String)
}

class USNewsDataSource : NSObject,UITableViewDataSource,UITableViewDelegate{
    
    var usArticle : [USAArticle]?
    var delegate : USNewsDataSourceProtocol?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usArticle?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(USNewsViewTableViewCell.self, for: indexPath)
        if let usArticlee = usArticle?[indexPath.row]{
            cell.usnewsArticle = usArticlee
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = usArticle?[indexPath.row].urlToImage else {return}
        self.delegate?.openURL(url: url)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
}
