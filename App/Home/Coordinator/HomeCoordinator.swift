//
//  HomeCoordinator.swift
//  NewsReadingApp
//
//  Created by Rion on 12.9.25.
//

import UIKit
import Foundation

class HomeCoordinator: DefaultCoordinator{
  
    var viewController : HomeViewController?
    var viewModel : HomeViewModelProtocol?
    var teslaCoordiantor : TeslaNewsCoordinator?
    var coordinateDelegate : HomeViewProtocolDelegate?
    var mapsCoordinaor : MapsCoordinator?
   
    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
        self.viewModel?.coordinateDelegate = self
    }
    func start() {
        self.viewController = HomeViewController.instantiate(.story)
        self.viewController?.viewModel = self.viewModel
    
    }
}
extension HomeCoordinator : HomeViewProtocolDelegate{
    func showHome() {
        
    }
    
    func navigateToMandate() {
        mapsCoordinaor = MapsCoordinator(viewModel: MapsViewModel(), navigationController: self.viewController?.navigationController)
        mapsCoordinaor?.start()
    }
    
    func navigateToSportNews() {
        teslaCoordiantor = TeslaNewsCoordinator(viewModel: TeslaNewsListViewModel(), navigationController: self.viewController?.navigationController)
        teslaCoordiantor?.start()
        print("moved")
        
    }
    
    func navigateToMaps() {
        
    }
    
}
