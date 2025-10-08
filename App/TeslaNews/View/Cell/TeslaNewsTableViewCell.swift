//
//  TeslaNewsTableViewCell.swift
//  RioDailyNews
//
//  Created by Rion on 21.9.25.
//

import UIKit

class TeslaNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var teslaTitle: UILabel!
    @IBOutlet weak var teslaImageView: UIImageView!
    var teslaArticle : TeslaArticle!{
        
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
    func setDate(date: String){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T"
            guard let convertedDate = formatter.date(from: date) else {return}
        self.teslaTitle.text = "\(convertedDate.toString(format : "DD/MM/YY"))"
    }
    func setValues(){
        self.teslaImageView.cornerRadius = 10
        if let image  = teslaArticle.urlToImage, image != ""{
            self.teslaImageView.setImage(with: image)
        }
    
        else{
            self.teslaImageView.image = UIImage(named: "No_Image_Available")
        }
        self.teslaTitle.text = teslaArticle.title ?? ""
        self.content.text = teslaArticle.publishedAt ?? ""
        
        if let dateformat = teslaArticle.publishedAt{
            setDate(date: dateformat)
        }
        
    }
    
}
