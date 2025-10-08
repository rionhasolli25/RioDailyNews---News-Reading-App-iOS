//
//  ProductDatsSource.swift
//  NewsReadingApp
//
//  Created by Rion on 15.9.25.
//

import Foundation
import UIKit

protocol ProductDataSourceProtocol: AnyObject{
    func displayPageIndex()
    func navigateToMandate()
    func navigateToSportNews()
     
}

class ProductDatsSource: NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
   
    
    var latestNews: [LatestArticle]?
//    var imageArray : [String] = ["vegtables","sportt","economy","worldnews 1"]
//    var textArray : [String] = ["Health","Sport","Economy","News"]
//    var titleArray : [String] = ["You need help?","Just Click here","We are here for you!"]
    var delegate : ProductDataSourceProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestNews?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ProductCollectionViewCell.self, for: indexPath)
        if let latestNews = latestNews?[indexPath.row]{
            cell.latestnews = latestNews
            cell.onFavoriteTapped = { article in
                    print("⭐ \(article.title) tapped")
                }
        }
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.displayPageIndex()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.delegate?.navigateToMandate()
        }
        if indexPath.row == 1{
            self.delegate?.navigateToSportNews()
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView,
              let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        let offsetX = targetContentOffset.pointee.x
        let index = round(offsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth, y: 0)
    }
    
   

}
extension ProductDatsSource: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    let height = collectionView.bounds.height
    return CGSize(width: width, height: height)
  }
}
