//
//  Account.swift
//  RionApp.com
//
//  Created by Rion on 24.9.22.
//

import Foundation
import UIKit
protocol AccountProtocol: AnyObject {
    func initMain()
    func initInitalScreen()
}
class Account: NSObject {
    static let shared = Account()
    weak var delegate: AccountProtocol?
    
    func clear(){
        clearSavedData()
    }
    func initMain()
    {
        self.delegate?.initMain()
    }
    func initializeInitialScreen(){
        self.delegate?.initInitalScreen()
    }
    func clearSavedData(){
        
    }
}
