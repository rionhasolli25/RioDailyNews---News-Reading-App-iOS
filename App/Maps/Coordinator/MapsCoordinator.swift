//
//  MapsCoordinator.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//
import UIKit

class MapsCoordinator : PushCoordinator{
    
    func start() {
        guard let vc = viewController else { return }
            navigationController?.pushViewController(vc, animated: true)
            print("TeslaNewsCoordinator started → VC pushed")
    }

    
    var viewController: MapsViewViewController?
    var configuration: ((MapsViewViewController) -> ())?
    var navigationController: UINavigationController?
    var viewModel : MapsViewModelProtocol?
    
    init(viewModel : MapsViewModelProtocol,navigationController : UINavigationController?) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        self.viewController = MapsViewViewController.instantiate(.mapView)
        self.viewController?.viewModel = viewModel
        self.viewController?.coordinator = self
    }
   
}
