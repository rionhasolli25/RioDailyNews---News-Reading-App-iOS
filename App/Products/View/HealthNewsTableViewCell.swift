//
//  HealthNewsTableViewCell.swift
//  RioDailyNews
//
//  Created by Rion on 25.9.25.
//

import UIKit

class HealthNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var healthTitle: UILabel!
    @IBOutlet weak var healthImageview: UIImageView!
    var healthArticle : HealthArticle!{
        didSet{
            self.setValues()
        }
    }
    let backgroundContainer = UIView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet weak var healthViewww: UIView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setValues(){
        self.healthImageview.cornerRadius = 10
        if let image  = healthArticle.urlToImage, image != ""{
            self.healthImageview.setImage(with: image)
        }
        
        else{
            self.healthImageview.image = UIImage(named: "No_Image_Available")
        }
        self.healthTitle.text = healthArticle.title ?? ""
        
        
    }
    
}
