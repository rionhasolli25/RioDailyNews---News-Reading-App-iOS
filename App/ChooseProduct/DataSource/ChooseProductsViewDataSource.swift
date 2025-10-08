//
//  ChooseProductsViewDataSource.swift
//  RionApp.com
//
//  Created by Rion on 13.2.23.
//

import Foundation
import UIKit

class ChooseProductsViewDataSource : NSObject,UITableViewDelegate,UITableViewDataSource{
    var aboutArray : [String] = ["About","Version Story","Contact Us"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(OthersListTableViewCell.self, for: indexPath)
        cell.textt.text = aboutArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
