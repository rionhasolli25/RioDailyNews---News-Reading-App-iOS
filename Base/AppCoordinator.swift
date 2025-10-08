//
//  AppCoordinator.swift
//  RionApp.com
//
//  Created by Rion on 24.9.22.
//

import UIKit
class AppCoordinator: Coordinator{
    // MARK: - Properties
    let window: UIWindow
    var tabCoordinator: TabBarCoordinator?
    var homeCoordinator : HomeCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
      initializeMainApp()
    }
    
    private func initializeSplashScreen()
    {
        homeCoordinator = HomeCoordinator()
        homeCoordinator?.coordinateDelegate = self
        Account.shared.delegate = self
        homeCoordinator?.start()
        if let vc = homeCoordinator?.viewController{
            let nav = BaseNavigationController(rootViewController: vc)
            nav.navigationBar.isHidden = true
            window.rootViewController = nav
        }
    }
//
//    private func loginScreen(){
//        loginCoordinator = LoginCoordinator(viewModel: LoginViewModel(), navigationController: self.introScreenCoordinator?.viewController?.navigationController)
//        loginCoordinator?.coordinatorDelegate = self
//        loginCoordinator?.start()
//        if let vc = loginCoordinator?.viewController{
//            let nav = BaseNavigationController(rootViewController: vc)
//            nav.navigationBar.isHidden = true
//            window.rootViewController = nav
//        }
//    }
    
//    private func initalizeIntroScreen(){
//        introScreenCoordinator = IntroScreenCoordinator()
//        // introScreenCoordinator?.coordinatorDelegate = self
//        introScreenCoordinator?.start()
//        if let vc = introScreenCoordinator?.viewController{
//            let nav = BaseNavigationController(rootViewController: vc)
//            nav.navigationBar.isHidden = true
//            window.rootViewController = nav
//        }
//    }
    func initializeMainApp(){
        let tabBarController = MainTabBarContainer.instantiate(.tabbar)
//        Account.shared.delegate = self
        let nav =  UINavigationController(rootViewController: tabBarController)
        UIApplication.shared.windows.first?.rootViewController = nav

        tabCoordinator = TabBarCoordinator(tabBarController:tabBarController, appLayout: MainAppLayout())
        tabCoordinator?.start()
    }
}


//extension AppCoordinator : IntroScreenProtocolDelegate{
//    func sendToSignUpScreen() {
//        introScreenCoordinator = nil
////        loginScreen()
//    }
//    func showStructeredProjectScreen() {
//        introScreenCoordinator = nil
////        loginScreen()
//    }
//}
//extension AppCoordinator : SplashScreenCoordinatorDelegate{
//    func showIntro() {
//        splashScreenCoordinator = nil
//        initalizeIntroScreen()
//    }
//}
//
extension AppCoordinator : HomeViewProtocolDelegate{
    func navigateToMaps() {
    }
    
    func navigateToSportNews() {
    }
    
    func navigateToMandate() {
    }
    
    func showHome() {
        homeCoordinator = nil
    }
}
extension AppCoordinator : AccountProtocol{
    func initInitalScreen() {}
    
    func initMain() {
        homeCoordinator = nil
        self.initializeMainApp()
    }
    
}
