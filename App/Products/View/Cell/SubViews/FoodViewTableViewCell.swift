//
//  FoodViewTableViewCell.swift
//  RioDailyNews
//
//  Created by Rion on 2.10.25.
//

import UIKit

class FoodViewTableViewCell: UITableViewCell {
    @IBOutlet weak var promotText: UILabel!
    
    @IBOutlet weak var imageVieww: UIImageView!
    var Appleproducts : LatestArticle!{
        didSet{
            setvalues()
        }
    }
    

    @IBOutlet weak var foodVieww: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setvalues(){
        self.imageVieww.cornerRadius = 10
        self.promotText.text = Appleproducts?.title
        if let img = Appleproducts?.urlToImage,img != ""{
            self.imageVieww.setImage(with: img)
        }

    }
    
}
