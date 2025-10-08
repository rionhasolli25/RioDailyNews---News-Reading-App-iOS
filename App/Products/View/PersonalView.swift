//
//  PersonalView.swift
//  RionApp.com
//
//  Created by Rion on 28.1.23.
//

import UIKit
import MapKit


class PersonalView: UIView {

    

    @IBOutlet weak var techNewsTableView: UITableView!
    
    var secondViewModel : TechNewsViewModelProtocol?
    

    override func willMove(toSuperview newSuperview: UIView?) {
        techNewsTableView.alwaysBounceVertical = true
        setupTable()
        setupApi()
        addPullToRefresh()
    }
    func setupTable(){
        techNewsTableView.register(TechNewsTableViewCell.self)
        techNewsTableView.dataSource = secondViewModel?.techNewsDataSource
        techNewsTableView.delegate = secondViewModel?.techNewsDataSource
        print("Datasource:", self.secondViewModel?.techNewsDataSource as Any)
        
    }
    
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        techNewsTableView.refreshControl = refreshControl
    }
    @objc private func refreshContent() {
        setupApi()
        techNewsTableView.refreshControl?.endRefreshing()
    }
  
    func setupApi(){
        self.secondViewModel?.getTechNews(completion: { response in
            HIDE_CUSTOM_LOADER()
            self.secondViewModel?.getTechNewsList(list: response?.articles)
            print("API returned articles:", response?.articles?.count ?? 0)
            DispatchQueue.main.async{
                    self.techNewsTableView.reloadData()
               
            }
        
        })
    }
    func openURLPage(url: String) {
        print("FoodView forwarding URL:", url)
        secondViewModel?.coordinateDelegate?.openURLPage(url: url)
    }
      

}


