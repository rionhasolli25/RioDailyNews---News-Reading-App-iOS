//
//  Loader.swift
//  RioDailyNews
//
//  Created by Rion on 3.10.25.
//

import UIKit
import NVActivityIndicatorView
import Foundation
import SystemConfiguration


private var activityRestorationIdentifier : String{
    return "NVActivityIndicatorViewContainer"
}
public func ShowLoaderWithMessage(message : String){
    startActivityAnimating(size: CGSize(width:56,height: 56), message: message, type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor.white, padding: 2, isFromOnView: false)
}

public func SHOW_CUSTOM_LOADER(){
    startActivityAnimating(size: CGSize(width:56,height:56), message: nil, type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor.white, padding: 2, isFromOnView: false)
}
public func SHOW_CUSTOM_LOADER_MSG(message:String){
    startActivityAnimating(size: CGSize(width:56,height: 56), message: nil, type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor.white, padding: 2, isFromOnView: false)
}

public func HIDE_CUSTOM_LOADER(){
    stopActivityAnimating(isFromOnView: false)
}

public func ShowLoaderOnView(){
    startActivityAnimating(size: CGSize(width:56,height: 56), message: nil, type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor.white, padding: 2, isFromOnView: true)
}
public func HideLoaderOnView(){
    stopActivityAnimating(isFromOnView: true)
}


private func startActivityAnimating(size: CGSize? = nil, message: String? = nil, type: NVActivityIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil, isFromOnView:Bool) {
    let activityContainer: UIView = UIView(frame: CGRect(x:0, y:0,width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
    activityContainer.backgroundColor = UIColor.white.withAlphaComponent(0.9)
    activityContainer.restorationIdentifier = activityRestorationIdentifier

    activityContainer.isUserInteractionEnabled = false
    let actualSize = size ?? CGSize(width:56,height:56)
    
    let activityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x:0, y:0, width:actualSize.width, height:actualSize.height),
        type: type!,
        color:.lightGray,
        padding: padding!)
    
    activityIndicatorView.center = activityContainer.center
    activityIndicatorView.startAnimating()
    activityContainer.addSubview(activityIndicatorView)
    
    
    if message != nil {
        let width = activityContainer.frame.size.width / 2
        if let message = message , !message.isEmpty {
            let label = UILabel(frame: CGRect(x:0, y:0,width:width, height:30))
            label.center = CGPoint(
                x:activityIndicatorView.center.x, y:
                    activityIndicatorView.center.y + actualSize.height)
            label.textAlignment = .center
            label.text = message
            label.textColor = activityIndicatorView.color
            activityContainer.addSubview(label)
        }
    }
    UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
    if isFromOnView == true {
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(activityContainer)
    } else {
        UIApplication.shared.keyWindow?.addSubview(activityContainer)
    }
}


private func stopActivityAnimating(isFromOnView:Bool){
    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
    if isFromOnView == true{
        for item in (UIApplication.shared.keyWindow?.rootViewController?.view.subviews)!
        where item.restorationIdentifier == activityRestorationIdentifier{
            item.removeFromSuperview()
            
        }
    }
    else{
        if Reachability.isConnectedToNetwork(){
            do{
                for item in (UIApplication.shared.keyWindow?.rootViewController?.view.subviews)!
                where item.restorationIdentifier == activityRestorationIdentifier{
                    item.removeFromSuperview()
                }
            }
            
        }
        else{
            NABHelper.shared.showNoConnectivityAlert()
        }
    }
}

public class Reachability{
    
    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
    
}

class NABHelper: NSObject {
    static let shared = NABHelper()
    var window: UIWindow?
    class func getCurrentMillis() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    func showNoConnectivityAlert(){
        let alert = UIAlertController(title: "Internet Connection not Available!", message: "Your device is not connected to the Internet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }))
        if let rootViewController = UIApplication.getTopMostViewController() {
            //do sth with root view controller
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIApplication {

    class func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}
