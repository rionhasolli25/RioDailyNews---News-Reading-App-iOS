//
//  Coordinator.swift
//  RionApp.com
//
//  Created by Rion on 24.9.22.
//

import Foundation
import UIKit


// Base Coordinator protocol
public protocol Coordinator {
    /// Trigge navigation to the corresponding controller
    func start()
    
    /// Stops corresponding controller and returns back to previous one
    func stop()
}

/// Stop methods is optional
extension Coordinator {
    func stop() {
    }
}


// MARK : DefaultCoordinator
// DefaultCoordinator conforming to Coordinator which supports Delegation
public protocol DefaultCoordinator: Coordinator {
    associatedtype VC: UIViewController
    var viewController: VC? { get set }
    
    var animated: Bool { get }
    var delegate: CoordinatorDelegate? { get }
}

extension DefaultCoordinator {
    // default implementation if not overriden
    var animated: Bool {
        get {
            return true
        }
    }
    
    // default implementation of nil delegate, should be overriden when needed
    weak var delegate: CoordinatorDelegate? {
        get {
            return nil
        }
    }
}

// MARK : PushCoordinator

// Coordinator for supporting Pushing and popoing the navigation controller
public protocol PushCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController? { get }
}

extension PushCoordinator where VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }
        
        configuration?(viewController)
        viewController.setCoordinator(self)
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func stop() {
        delegate?.willStop(in: self)
        navigationController?.popViewController(animated: animated)
        delegate?.didStop(in: self)
    }
    
}

// MARK : ModalCoordinator

// Coordinator for supporting Presenting and Dismissing a Modal
public protocol ModalCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController? { get }
    var destinationNavigationController: UINavigationController? { get }
}

extension ModalCoordinator where VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }
        
        configuration?(viewController)
        viewController.setCoordinator(self)
        
        if let destinationNavigationController = destinationNavigationController {
            // wrapper navigation controller given, present it
            navigationController?.present(destinationNavigationController, animated: animated, completion: nil)
        } else {
            // no wrapper navigation controller given, present actual controller
            navigationController?.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func stop() {
        delegate?.willStop(in: self)
        viewController?.dismiss(animated: true, completion: {
            self.delegate?.didStop(in: self)
        })
    }
}



// MARK : CoordinatorDelegate

// Delegate that would define additional operation before stopping coordinator
public protocol CoordinatorDelegate: AnyObject {
    func willStop(in coordinator: Coordinator)
    func didStop(in coordinator: Coordinator)
}

// MARK : Coordinated

/// Used typically on view controlle to refer to it's coordinator
public protocol Coordinated {
    func getCoordinator() -> Coordinator?
    func setCoordinator(_ coordinator: Coordinator)
}


