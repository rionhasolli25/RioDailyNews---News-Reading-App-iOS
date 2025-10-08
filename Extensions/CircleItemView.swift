//
//  CircleItemView.swift
//  NewsReadingApp
//
//  Created by Rion on 17.9.25.
//

import Foundation
import UIKit

extension String{
    var isEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:" SELF MATCHES %@",emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

//extension UIViewController{
//    func showAlertWith(title: String, message: String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
//        self.present(alert, animated: true)
//    }
//    func showOKAlert(title : String, message: String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true)
//    }
//}
extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, font: UIFont, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}


extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}


extension NSMutableAttributedString {

    // Replaces the base font (typically Times) with the given font, while preserving traits like bold and italic
    func setBaseFont(baseFont: UIFont, color: UIColor, preserveFontSizes: Bool = false) {
        let baseDescriptor = baseFont.fontDescriptor
        let wholeRange = NSRange(location: 0, length: length)
        beginEditing()
        enumerateAttribute(.font, in: wholeRange, options: []) { object, range, _ in
            guard let font = object as? UIFont else { return }
            // Instantiate a font with our base font's family, but with the current range's traits
            let traits = font.fontDescriptor.symbolicTraits
            guard let descriptor = baseDescriptor.withSymbolicTraits(traits) else { return }
            let newSize = preserveFontSizes ? descriptor.pointSize : baseDescriptor.pointSize
            let newFont = UIFont(descriptor: descriptor, size: newSize)
            self.removeAttribute(.font, range: range)
            self.addAttribute(.font, value: newFont, range: range)
            self.addAttribute(NSAttributedString.Key.foregroundColor,value: color, range:range)
        }
        endEditing()
    }
}

//extension UITextView {
//
//    private class PlaceholderLabel: UILabel { }
//
//    private var placeholderLabel: PlaceholderLabel {
//        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
//            return label
//        } else {
//            let label = PlaceholderLabel(frame: .zero)
//            label.font = Fonts.robotoMedium(size: 16)
//            label.textColor = UIColor(hexString: "#C7C7CD")
//            addSubview(label)
//            return label
//        }
//    }

//    @IBInspectable
//    var placeholder: String {
//        get {
//            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
//        }
//        set {
//            let placeholderLabel = self.placeholderLabel
//            placeholderLabel.text = newValue
//            placeholderLabel.numberOfLines = 0
//            let width = frame.width - textContainer.lineFragmentPadding * 2
//            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
//            placeholderLabel.frame.size.height = size.height
//            placeholderLabel.frame.size.width = width
//            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top+5)
//
//            textStorage.delegate = self
//        }
//    }
//
//}

//extension UITextView: NSTextStorageDelegate {
//
//    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
//        if editedMask.contains(.editedCharacters) {
//            placeholderLabel.isHidden = !text.isEmpty
//        }
//    }

//}

