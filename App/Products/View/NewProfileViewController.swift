//
//  NewProfileViewController.swift
//  RionApp.com
//
//  Created by Rion on 25.1.23.
//

import UIKit
import SafariServices
import WebKit

class NewProfileViewController: UIViewController,Storyboarded,SFSafariViewControllerDelegate,WKUIDelegate{
    
    @IBOutlet weak var usNewsBtn: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var checkFoodView: UIButton!
    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navigationView: UIView!
    
    var viewModel : TechNewsViewModelProtocol?
    var secondViewModel : MyWalletViewModelProtocol?
    var thirdViewModel : AppleNewsViewModelProtocol?
    var usViewModel : USNewsViewModelProtocol?
    
    var coordinator : NewProfileCoordinator?
    let walletView = Bundle.main.loadNibNamed("FoodView", owner: HomeViewController.self, options: nil)?.first as? FoodView
    let mapView = Bundle.main.loadNibNamed("PersonalView", owner: HomeViewController.self, options: nil)?.first as? PersonalView
    let newsV = Bundle.main.loadNibNamed("NewsView", owner: HomeViewController.self, options: nil)?.first as? NewsView
    let usNEWsV = Bundle.main.loadNibNamed("USNewsView", owner: HomeViewController.self,options: nil)?.first as? USNewsView
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupWalletsView()
        secondViewModel = MyWalletViewModel()
        viewModel = TechNewsViewModel()
        thirdViewModel = AppleNewsViewModel()
        usViewModel = USNewsViewModel()
        self.viewModel?.coordinateDelegate = self
        self.secondViewModel?.coordinateDelegate = self
        self.thirdViewModel?.coordinateDelegate = self
        self.usViewModel?.coordinateDelegate = self
//        mapView?.viewModel?.coordinateDelegate = self
        animateView(selected: checkFoodView, deselect1: walletButton, deselect2: thirdButton)
        newsV?.appleviewModel?.coordinateDelegate = self
        walletView?.viewModel?.coordinateDelegate = self
        mapView?.secondViewModel?.coordinateDelegate = self
        newsV?.appleviewModel?.coordinateDelegate = self
        newsV?.appleviewModel = thirdViewModel
    }

    func setupWalletsView() {
        guard let walletV = walletView else { return }

        walletV.viewModel = MyWalletViewModel()
        // Assign the proper viewModel only if it's not set yet
        if walletV.viewModel == nil {
            walletV.viewModel = secondViewModel
        }

        // Only add the view if it's not already in the container
        if walletV.superview == nil {
            walletV.frame = containerView.bounds
            walletV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            containerView.addSubview(walletV)
        } else {
            // If it's already added, just bring it to front
            containerView.bringSubviewToFront(walletV)
        }
    }
//    func setupWalletsView(){
////        guard let walletV = walletView else {return}
////        walletV.viewModel = MyWalletViewModel()
////        walletView?.removeFromSuperview()
////        
////        walletV.frame.size.height = containerView.frame.size.height
////        walletV.frame.size.width = containerView.frame.size.width
////        containerView.addSubview(walletV)
////
//        guard let walletV = walletView else { return }
//        
//        walletV.viewModel = MyWalletViewModel()
//
//                // Reuse the existing view model
////                walletV.viewModel = secondViewModel
//                // Remove old subview if exists
//                walletV.removeFromSuperview()
//
//        walletV.frame.size.height = containerView.frame.size.height
//        walletV.frame.size.width = containerView.frame.size.width
//                containerView.addSubview(walletV)
//    }
    func setupPersonalDetailsView(){
        guard let personalDetailsV = mapView else {return}
        personalDetailsV.secondViewModel = TechNewsViewModel()
        personalDetailsV.secondViewModel = viewModel
        walletView?.removeFromSuperview()
        walletView?.removeFromSuperview()
        personalDetailsV.frame.size.height = containerView.frame.size.height
        personalDetailsV.frame.size.width = containerView.frame.size.width
        containerView.addSubview(personalDetailsV)
    }
    func setupNewsView(){
        guard let newsV = newsV else {return}
        newsV.appleviewModel = AppleNewsViewModel()
        newsV.appleviewModel = thirdViewModel
        newsV.removeFromSuperview()
        newsV.frame.size.height = containerView.frame.size.height
        newsV.frame.size.width = containerView.frame.size.width
        containerView.addSubview(newsV)
    }
    func setupUSNewsView(){
        guard let newsV = usNEWsV else {return}
        newsV.usViewModel = USNewsViewModel()
        newsV.usViewModel = usViewModel
        newsV.removeFromSuperview()
        newsV.frame.size.height = containerView.frame.size.height
        newsV.frame.size.width = containerView.frame.size.width
        containerView.addSubview(newsV)
    }
    func animateView(selected: UIButton, deselect1: UIButton,deselect2: UIButton){
        UIView.animate(withDuration: 0.5) {
            self.navigationView.center.x = selected.center.x
            selected.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
            selected.setTitleColor(UIColor(hexString: "#00263c"), for: .normal)
            deselect1.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
            deselect1.setTitleColor(UIColor(hexString: "#969696"), for: .normal)
            deselect2.titleLabel?.font =   UIFont.systemFont(ofSize: 12)
            deselect2.setTitleColor(UIColor(hexString: "#969696"), for: .normal)
        }
    }
    
    @IBAction func usnewsBtn(_ sender: Any) {
        setupUSNewsView()
        animateView(selected: usNewsBtn, deselect1: checkFoodView,deselect2: thirdButton)
    }
    @IBAction func walletBtn(_ sender: Any) {
        setupWalletsView()
        animateView(selected: walletButton, deselect1: checkFoodView,deselect2: thirdButton)
    }
    @IBAction func checkFoodBtn(_ sender: Any) {
        setupPersonalDetailsView()
        animateView(selected: checkFoodView, deselect1: walletButton,deselect2: thirdButton)
    }
    @IBAction func thirdButtonBtn(_ sender: Any) {
       setupNewsView()
        animateView(selected: thirdButton, deselect1: checkFoodView, deselect2: walletButton)
    }
}
extension NewProfileViewController : WalletViewDelegateProtocol{
    func showEditAccount() {}
    
    func openURLPage(url: String) {
        print("Controller presenting Safari:", url) // 🔍 confirm log
        guard let url = URL(string: url) else {
        return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}
extension NewProfileViewController : TechNewsViewModelProtocolViewDelegate{
    func openUrl(url: String) {
        print("Controller presenting Safari:", url) // 🔍 confirm log
        guard let url = URL(string: url) else {
        return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}
extension NewProfileViewController : AppleNewsDelegateProtocol{
    func openURLLPage(url: String) {
        print("Controller presenting Safari:", url) // 🔍 confirm log
        guard let url = URL(string: url) else {
        return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}
extension NewProfileViewController: USNewsViewDelegate{
    func showURL(url: String) {
        print("Controller presenting Safari:", url) // 🔍 confirm log
        guard let url = URL(string: url) else {
        return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }

    
}
