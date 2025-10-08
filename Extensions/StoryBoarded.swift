//
//  StoryBoarded.swift
//  RionApp.com
//
//  Created by Rion on 24.9.22.
//

import Foundation
import UIKit
protocol Storyboarded {
    static func instantiate(_ storyboard: UIStoryboard) -> Self
}
extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboard: UIStoryboard) -> Self {
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
}
extension UIStoryboard{
    static var chooseProductDetails : UIStoryboard{
        return UIStoryboard(name: "ChooseProductDetails", bundle: nil)
    }
    static var newsList: UIStoryboard{
        return UIStoryboard(name: "NewsList", bundle: nil)
    }
    static var chooseProduct : UIStoryboard{
        return UIStoryboard(name: "ChooseProductView", bundle: nil)
    }
    static var newProfile : UIStoryboard{
        return UIStoryboard(name: "NewProfile", bundle: nil)
    }
    static var personalProfile : UIStoryboard{
        return UIStoryboard(name: "PersonalProfile", bundle: nil)
    }
    static var mandateScreen : UIStoryboard{
        return UIStoryboard(name: "Mandate", bundle: nil)
    }
    static var secondScreen : UIStoryboard{
        return UIStoryboard(name: "SecondScreen", bundle: nil)
    }
    static var story : UIStoryboard{
        return UIStoryboard(name: "Home", bundle: nil)
    }
    static var tabbar: UIStoryboard {
           return UIStoryboard(name: "TabBar", bundle: nil)
       }
    static var healthNews : UIStoryboard{
        return UIStoryboard(name: "HealthNews", bundle: nil)
    }
    static var mapView : UIStoryboard{
        return UIStoryboard(name: "MapView", bundle: nil)
    }
    static var teslaNews: UIStoryboard{
        return UIStoryboard(name: "TeslaNewList", bundle: nil)
    }
    static var bitcoinNews : UIStoryboard{
        return UIStoryboard(name: "BitcoinNews", bundle: nil)
    }
    static var mapsView : UIStoryboard{
        return UIStoryboard(name: "MapView", bundle: nil)
    }
}
extension UIStoryboard{
    func instanitate<T:UIViewController>(_ : T.Type,identifier : String? = nil) -> T{
        return self.instantiateViewController(withIdentifier: identifier ?? String(describing: T.self)) as! T
    }

}
