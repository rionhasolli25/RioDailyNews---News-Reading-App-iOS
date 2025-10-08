//
//  NewsDataSource.swift
//  NewsReadingApp
//
//  Created by Rion on 12.9.25.
//

import Foundation
import UIKit

protocol NewsDataSourceProtocol: AnyObject{
    func openWebPage(url:String)
}

class NewsDataSource: NSObject,UITableViewDelegate,UITableViewDataSource{
   
    var appleNews : [AppleArticle]?
    var delegate : NewsDataSourceProtocol?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(PromotionTableViewCell.self, for: indexPath)
        if let appleNews = appleNews?[indexPath.row]{
            cell.appleArr = appleNews
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = appleNews?[indexPath.row].url else {return}
        self.delegate?.openWebPage(url: url)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}



class SnappingFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        let targetRect = CGRect(x: 0,
                                y: proposedContentOffset.y,
                                width: collectionView.bounds.size.width,
                                height: collectionView.bounds.size.height)

        guard let attributes = super.layoutAttributesForElements(in: targetRect) else {
            return proposedContentOffset
        }

        // Center of where collectionView is going to stop
        let centerY = proposedContentOffset.y + collectionView.bounds.size.height / 2
        var closest = CGFloat.greatestFiniteMagnitude

        for attr in attributes {
            if abs(attr.center.y - centerY) < abs(closest) {
                closest = attr.center.y - centerY
            }
        }

        return CGPoint(x: proposedContentOffset.x,
                       y: proposedContentOffset.y + closest)
    }
}
