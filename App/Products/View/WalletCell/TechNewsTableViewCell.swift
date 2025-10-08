//
//  WalletCellTableViewCell.swift
//  RionApp.com
//
//  Created by Rion on 3.2.23.
//

import UIKit

class TechNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var techNewsImageView: UIImageView!
    @IBOutlet weak var techNewsTitle: UILabel!
    
    var techNewsArticle : TechNewsArticle!{
        didSet{
            setVAlues()
        }
    }
    
    @IBOutlet weak var techNewsImageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setVAlues(){
        self.techNewsImageView.cornerRadius = 10
        if let image  = techNewsArticle.urlToImage, image != ""{
            self.techNewsImageView.setImage(with: image)
        }
    
        else{
            self.techNewsImageView.image = UIImage(named: "No_Image_Available")
        }
        self.techNewsTitle.text = techNewsArticle.title ?? ""
        
       
    }
    }
    

