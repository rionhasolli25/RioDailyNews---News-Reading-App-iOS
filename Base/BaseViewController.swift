//
//  BaseViewController.swift
//  RionApp.com
//
//  Created by Rion on 24.9.22.
//

import Foundation
import UIKit
class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
    }
}
