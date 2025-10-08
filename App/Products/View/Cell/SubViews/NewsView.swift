//
//  NewsView.swift
//  RionApp.com
//
//  Created by Rion on 12.4.23.
//

import UIKit
import SafariServices
import WebKit

class NewsView: UIView,SFSafariViewControllerDelegate,WKUIDelegate{
   


    @IBOutlet weak var lastNewsTableView: UITableView!
    var appleviewModel: AppleNewsViewModelProtocol?
    
    override func willMove(toSuperview newSuperview: UIView?) {
        getAPI()
        setCollection()
        addPullToRefresh()
        lastNewsTableView.alwaysBounceVertical = true
    }
    func setCollection(){
        self.lastNewsTableView.register(FoodViewTableViewCell.self)
        self.lastNewsTableView.dataSource = self.appleviewModel?.appleNewsDataSource
        self.lastNewsTableView.delegate = self.appleviewModel?.appleNewsDataSource
        lastNewsTableView.separatorStyle = .singleLine
        lastNewsTableView.separatorColor = .lightGray
        lastNewsTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        print("Datasource:", self.appleviewModel?.appleNewsDataSource as Any)
    
    }
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        lastNewsTableView.refreshControl = refreshControl
    }


    @objc private func refreshContent() {
        getAPI()
        lastNewsTableView.refreshControl?.endRefreshing()
    }
    func getAPI(){
        self.appleviewModel?.appleNews(completion: { response in
            HIDE_CUSTOM_LOADER()
            print(response ?? "")
            self.appleviewModel?.AppleListnews(list: response?.articles)
                   self.lastNewsTableView.reloadData()
          
        })
    }
}
//extension NewsView : AppleNewsDelegateProtocol{
//    func openUrl(url: String) {
//       
//    }
//    
//    
//}
//
//   
