//
//  Table&CollectionViewComponents.swift
//  RionApp.com
//
//  Created by Rion on 24.9.22.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let nib = UINib(nibName: reuseIdentifier ?? String(describing: T.self), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
}
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let nib = UINib(nibName: reuseIdentifier ?? String(describing: T.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
}
extension UITableView {
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type, reuseIdentifier: String? = nil) {
        let nib = UINib(nibName: reuseIdentifier ?? String(describing: T.self), bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        guard
            let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
            
            else { fatalError("Could not deque cell with type \(T.self)") }
        
        return view
    }
}

