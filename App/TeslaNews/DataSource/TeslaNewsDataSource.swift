//
//  TeslaNewsDataSource.swift
//  RioDailyNews
//
//  Created by Rion on 21.9.25.
//

import UIKit
import Foundation

protocol TeslaNewsDataSourceViewDelegate : AnyObject{
    func openWebPage(url:String)
    
}
class TeslaNewsDataSource: NSObject,UITableViewDelegate,UITableViewDataSource{
  
    var delegate : TeslaNewsDataSourceViewDelegate?
    var teslaNews: [TeslaArticle]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teslaNews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TeslaNewsTableViewCell.self, for: indexPath)
        if let TesslaArticle = teslaNews?[indexPath.row]{
            cell.teslaArticle = TesslaArticle
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = teslaNews?[indexPath.row].url else {return}
        self.delegate?.openWebPage(url: url)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 250
        }
        else{
            return 180
        }
    }
    
}
    

