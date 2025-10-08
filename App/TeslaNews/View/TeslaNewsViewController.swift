//
//  TeslaNewsViewController.swift
//  RioDailyNews
//
//  Created by Rion on 21.9.25.
//

import UIKit
import SafariServices

class TeslaNewsViewController: UIViewController,Storyboarded, SFSafariViewControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    var viewModel :  TeslaNewsViewModelProtocol?
    var teslaCoordinator : TeslaNewsCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAPI()
        setupTableView()
        self.viewModel?.viewDelegate = self
    }
    func setupTableView(){
        tableView.register(TeslaNewsTableViewCell.self)
        tableView.dataSource = self.viewModel?.teslaDataSource
        tableView.delegate = self.viewModel?.teslaDataSource
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    @IBAction func btnaction(_ sender: Any) {
        self.teslaCoordinator?.stop()
        print("back")
    }
    func setupAPI(){
        self.viewModel?.getTeslatNews(completion: { response in
            print(response ?? "")
            self.viewModel?.getTeslaList(list: response?.articles)
            self.tableView.reloadData()
        })
    }
}
extension TeslaNewsViewController : TeslaNewsListViewModelViewDelagate{
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("click")
        return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}
