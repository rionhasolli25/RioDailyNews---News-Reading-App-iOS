//
//  TeslaNewsCoordinator.swift
//  RioDailyNews
//
//  Created by Rion on 21.9.25.
//

import Foundation
import UIKit

class TeslaNewsCoordinator : PushCoordinator{
    
    func start() {
        guard let vc = viewController else { return }
            navigationController?.pushViewController(vc, animated: true)
            print("TeslaNewsCoordinator started → VC pushed")
    }
    
   
    
    var viewController: TeslaNewsViewController?
    var configuration: ((TeslaNewsViewController) -> ())?
    var navigationController: UINavigationController?
    var viewModel : TeslaNewsViewModelProtocol?
    
    init(viewModel : TeslaNewsViewModelProtocol,navigationController : UINavigationController?) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        self.viewController = TeslaNewsViewController.instantiate(.teslaNews)
        self.viewController?.viewModel = viewModel
    }
   
}
