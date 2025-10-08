//
//  USNewsViewTableViewCell.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//

import UIKit

class USNewsViewTableViewCell: UITableViewCell {

    @IBOutlet weak var usNewsImageView: UIImageView!
    @IBOutlet weak var USnewsTitleDesc: UILabel!
    var usnewsArticle : USAArticle!{
        didSet{
            setValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues(){
        self.USnewsTitleDesc.text = usnewsArticle.title ?? ""
        
        if let image = usnewsArticle.urlToImage, image != ""{
            self.usNewsImageView.setImage(with: image)
        }
        self.usNewsImageView.cornerRadius = 10
    }
}
