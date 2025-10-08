//
//  FoodViewDataSource.swift
//  RionApp.com
//
//  Created by Rion on 26.1.23.
//

import Foundation
import UIKit

protocol AppleNewsDataSourceProtocol : AnyObject{
    func openURLPage(url:String)
}
class AppleNewsDataSource : NSObject,UITableViewDataSource,UITableViewDelegate{
   
    var delegate : AppleNewsDataSourceProtocol?
    var AppleNewsproducts : [LatestArticle]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppleNewsproducts?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FoodViewTableViewCell.self, for: indexPath)
        if let products = AppleNewsproducts?[indexPath.row]{
            cell.Appleproducts = products
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = AppleNewsproducts?[indexPath.row].url else {return}
        print("licyyk")
        self.delegate?.openURLPage(url: url)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
