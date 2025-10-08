//
//  ProductCollectionViewCell.swift
//  NewsReadingApp
//
//  Created by Rion on 15.9.25.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var onFavoriteTapped: ((LatestArticle) -> Void)?
    
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    var latestnews : LatestArticle!{
        didSet{
            setValues()
        }
    }
   
    
    @IBOutlet weak var productContent: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
    }

       @objc private func toggleFavorite() {
           guard let article = latestnews else { return }
           if FavoritesManager.shared.isFavorite(article) {
               FavoritesManager.shared.remove(article)
           } else {
               FavoritesManager.shared.save(article)
           }
           updateFavoriteState()
           onFavoriteTapped?(article)
       }
    
    func configure(with article: LatestArticle) {
        self.latestnews = article
        productTitle?.text = article.title
        productTitle?.text = article.description
        updateFavoriteState()
    }

    private func updateFavoriteState() {
        guard let article = latestnews else { return }
        let isFav = FavoritesManager.shared.isFavorite(article)
        favoriteButton.setImage(UIImage(systemName: isFav ? "star.fill" : "star"), for: .normal)
        favoriteButton.tintColor = isFav ? .systemYellow : .systemGray
    }

    func setValues(){
        self.productTitle.text = latestnews.title ?? ""
        self.productContent.text = latestnews.content ?? ""
        if let img = latestnews.urlToImage,img != ""{
            productImageView.setImage(with: img)
        }
    }
}
