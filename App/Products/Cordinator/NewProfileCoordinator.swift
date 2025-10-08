//
//  NewProfileCoordinator.swift
//  RionApp.com
//
//  Created by Rion on 25.1.23.
//

import Foundation

class NewProfileCoordinator : DefaultCoordinator {

   
    var viewController: NewProfileViewController?
    var viewModel : TechNewsViewModelProtocol?
    
    
    init(viewModel: TechNewsViewModelProtocol = TechNewsViewModel()) {
        self.viewModel = viewModel
    }
    func start() {
        self.viewController = NewProfileViewController.instantiate(.newProfile)
        self.viewController?.viewModel = self.viewModel
    }
    
}

extension NewProfileCoordinator : NewProfileProtocolViewDelegate{
    func openUrl(url: String) {
        
    }
    
    func showScreen() {
        
    }
    
    func openWebPage(url: String) {
        
    }
    
}
