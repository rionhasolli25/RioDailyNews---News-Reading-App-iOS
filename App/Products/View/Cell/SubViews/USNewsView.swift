//
//  USNewsView.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//

import UIKit

class USNewsView: UIView {
    @IBOutlet weak var usnewsTableView: UITableView!
    var usViewModel : USNewsViewModelProtocol?
    
    override func willMove(toWindow newWindow: UIWindow?) {
        setupTableView()
        setupapi()
        addPullToRefresh()
        usnewsTableView.alwaysBounceVertical = true
    }
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        usnewsTableView.refreshControl = refreshControl
    }
    @objc private func refreshContent() {
        setupapi()
        usnewsTableView.refreshControl?.endRefreshing()
    }
  
    func setupTableView(){
        self.usnewsTableView.register(USNewsViewTableViewCell.self)
        self.usnewsTableView.dataSource = self.usViewModel?.usnewsdataSource
        self.usnewsTableView.delegate = self.usViewModel?.usnewsdataSource
        usnewsTableView.separatorStyle = .singleLine
        usnewsTableView.separatorColor = .lightGray
        usnewsTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    func setupapi(){
        self.usViewModel?.getUSNews(completion: { response in
            self.usViewModel?.getUSNewsList(list: response?.articles)
            self.usnewsTableView.reloadData()
        })
    }
}
