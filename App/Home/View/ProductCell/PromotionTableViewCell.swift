//
//  PromotionTableViewCell.swift
//  NewsReadingApp
//
//  Created by Rion on 12.9.25.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var promotiontext: UILabel!
    @IBOutlet weak var promotionImageView: UIImageView!
    var appleArr : AppleArticle!{
        didSet{
            setValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.promotionImageView.layer.opacity = 0.50
        mainView.translatesAutoresizingMaskIntoConstraints = true
        mainView.frame =  contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        mainView.roundCorners(corners: [.allCorners], radius: 10)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setValues(){
        self.promotiontext.text = appleArr.title ?? ""
        if let img = appleArr.urlToImage,img != ""{
            promotionImageView.setImage(with: img)
        }
    }
}
