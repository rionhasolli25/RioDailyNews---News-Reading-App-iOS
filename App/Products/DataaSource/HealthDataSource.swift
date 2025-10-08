//
//  HealthDataSource.swift
//  RioDailyNews
//
//  Created by Rion on 25.9.25.
//
import UIKit

protocol HealthDataSourceViewDelegate : AnyObject{
    func openWebPage(url:String)
}

class HealthDataSource : NSObject,UITableViewDelegate,UITableViewDataSource{
    
    var delegate : HealthDataSourceViewDelegate?
    var healtharticle : [HealthArticle]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healtharticle?.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue(HealthNewsTableViewCell.self, for: indexPath)
        if indexPath.row == 0{
           
        }
        if let healtharticle = healtharticle?[indexPath.row]{
            cell.healthArticle = healtharticle
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = healtharticle?[indexPath.row].url  else {return}
        print("lick")
        self.delegate?.openWebPage(url: url)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 250
        }
        else{
            return 160
        }
    }
 
}
