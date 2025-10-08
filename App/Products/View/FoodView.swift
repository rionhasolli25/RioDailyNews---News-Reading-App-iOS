//
//  FoodView.swift
//  RionApp.com
//
//  Created by Rion on 27.1.23.
//

import UIKit


class FoodView: UIView{


    @IBOutlet weak var switchTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: MyWalletViewModelProtocol?

    override func willMove(toSuperview newSuperview: UIView?) {
        setupAPI()
        setuptableview()
        addPullToRefresh()
        switchTableView.alwaysBounceVertical = true
    }
    
   func setuptableview(){
       switchTableView.register(HealthNewsTableViewCell.self)
       switchTableView.dataSource = self.viewModel?.healthDataSource
       switchTableView.delegate = self.viewModel?.healthDataSource
       print("Datasource:", self.viewModel?.healthDataSource as Any)
       switchTableView.separatorStyle = .singleLine
       switchTableView.separatorColor = .lightGray
       switchTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        switchTableView.refreshControl = refreshControl
    }


    @objc private func refreshContent() {
        setupAPI()
        switchTableView.refreshControl?.endRefreshing()
    }
  
    func setupAPI(){
        self.viewModel?.getProducts(completion: { response in
            if response?.status == "ok" {
                print("API returned articles:", response?.articles?.count ?? 0)
                self.viewModel?.getList(list: response?.articles)
                self.switchTableView.reloadData()
            }
        })
    }
    func openURLPage(url: String) {
        print("FoodView forwarding URL:", url)
        viewModel?.coordinateDelegate?.openURLPage(url: url)
    }
      
}

