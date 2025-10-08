//
//  HomeViewController.swift
//  NewsReadingApp
//
//  Created by Rion on 12.9.25.
//

import Foundation
import UIKit
import SafariServices


class HomeViewController: UIViewController,Storyboarded,SFSafariViewControllerDelegate{
    
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    var viewModel : HomeViewModelProtocol?
    var autoScrollTimer: Timer?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.viewModel?.viewDelegate = self
        getNews()
        setupTableView()
        setupCollectionView()
        setupLatestNewsAPI()
        startAutoScroll()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 
        layout.sectionInset = .zero
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
    }
    override func viewDidLayoutSubviews() {
        containerView.roundCorners(corners: [.allCorners], radius: 20)
        infoView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
    }

    func setupTableView(){
        tableView.register(PromotionTableViewCell.self)
        tableView.dataSource = self.viewModel?.dataSource
        tableView.delegate = self.viewModel?.dataSource
        tableView.separatorColor = UIColor.clear
    }
    func setupCollectionView(){
        collectionView.register(ProductCollectionViewCell.self)
        collectionView.dataSource = self.viewModel?.promotionDataSource
        collectionView.delegate = self.viewModel?.promotionDataSource
    }
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func refreshContent() {
        getNews()
        setupLatestNewsAPI()
        tableView.refreshControl?.endRefreshing()
    }
    func startAutoScroll() {
        // Invalidate any previous timer to avoid duplicates
        autoScrollTimer?.invalidate()

        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [weak self] _ in
            guard let self = self,
                  let dataSource = self.viewModel?.promotionDataSource,
                  let itemsCount = dataSource.latestNews?.count,
                  itemsCount > 0 else { return }

            let visibleItems = self.collectionView.indexPathsForVisibleItems.sorted()
            guard let currentIndexPath = visibleItems.first else { return }

            let nextItem = (currentIndexPath.item + 1) % itemsCount
            let nextIndexPath = IndexPath(item: nextItem, section: 0)

            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }

    func setupLatestNewsAPI(){
        self.viewModel?.getAlbums(completion: { response in
            HIDE_CUSTOM_LOADER()
            print(response ?? "")
            self.viewModel?.getAlbumsList(list: response?.articles)
            self.collectionView.reloadData()
        })
    }
    func getNews(){
        HIDE_CUSTOM_LOADER()
        self.viewModel?.getAppleNews(completion: { response in
            print(response ?? "")
            self.viewModel?.getAppleNewslist(list: response?.articles)
            self.tableView.reloadData()
        })
    }

    @IBAction func btnaction(_ sender: Any) {
        print("click")
        self.viewModel?.showMandate()
    }
    
}

extension HomeViewController : HomeViewModelViewDelegate{
    func diaplayPageindex() {
        
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
        return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
        }
    }


