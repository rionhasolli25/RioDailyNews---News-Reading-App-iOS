//
//  ImageExtension.swift
//  RionApp.com
//
//  Created by Rion on 19.1.23.
//

import Foundation
import Kingfisher
import UIKit


extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
    
}
