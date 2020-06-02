//
//  ColorStruct.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

//Todo: Clean up names of the properties
struct SingletonStruct{
    
    //Egg white
    static let backgroundColor:UIColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)

    //Black
    static let titleColor:UIColor = UIColor(red: 7/255, green: 7/255, blue: 7/255, alpha: 1)
    
    //Salmon Pink
    static let pinkColor:UIColor = UIColor(red: 251/255, green: 199/255, blue: 212/255, alpha: 1)
    
    //Purple/Blue Mix
    static let purpColor:UIColor = UIColor(red: 151/255, green: 150/255, blue: 240/255, alpha: 1)
    
    //Dark Dark Grey / Matte Black
    static let blackColor:UIColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
    
    static let subHeaderFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 16)!
    static let inputFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    static let headerFont:UIFont = UIFont.init(name: "AvenirNext-DemiBold", size: 26)!
    static let secondaryHeaderFont:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 19)!
    static let inputItemFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    
    
    static let navTitle:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 23)!
    static let navBtnTitle:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 19)!
    static let clearImg:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 13)!
    
    static let tagInputFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 27)!
    
    static let pageOneHeader:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 30)!
    static let pageOneSubHeader:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 24)!
    static let inputLabel:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 24)!
    static let buttonFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    static let tagFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 29)!
    
    static let stackViewSeparator:CGFloat = 5.0
    
    static var doneMakingTrek:Bool = false
    
    
    static var untitledTrekCounter:Int = 0
    
    
    static let testBlack:UIColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    static let testGold:UIColor = UIColor(red: 255/255, green: 189/255, blue: 27/255, alpha: 1.0)
    static let testWhite:UIColor = UIColor(red: 247/255, green: 255/255, blue: 247/255, alpha: 1.0)
    static let testGray:UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)

}


//Put this somewhere
extension UIStackView {
    func stackAddBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 3
        insertSubview(subView, at: 0)
    }
}

//Put this somewhere
extension UIView {
    func viewAddBackground(imgName: String) {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    imageViewBackground.image = UIImage(named: imgName)

    // you can change the content mode:
    imageViewBackground.contentMode = .scaleAspectFill
    
    self.addSubview(imageViewBackground)
    self.sendSubviewToBack(imageViewBackground)
}}

//For addin
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}


// works with NSAttributedString and NSMutableAttributedString!
public extension NSAttributedString {
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let leftCopy = NSMutableAttributedString(attributedString: left)
        leftCopy.append(right)
        return leftCopy
    }

    static func + (left: NSAttributedString, right: String) -> NSAttributedString {
        let leftCopy = NSMutableAttributedString(attributedString: left)
        let rightAttr = NSMutableAttributedString(string: right)
        leftCopy.append(rightAttr)
        return leftCopy
    }

    static func + (left: String, right: NSAttributedString) -> NSAttributedString {
        let leftAttr = NSMutableAttributedString(string: left)
        leftAttr.append(right)
        return leftAttr
    }
}

public extension NSMutableAttributedString {
    static func += (left: NSMutableAttributedString, right: String) -> NSMutableAttributedString {
        let rightAttr = NSMutableAttributedString(string: right)
        left.append(rightAttr)
        return left
    }

    static func += (left: NSMutableAttributedString, right: NSAttributedString) -> NSMutableAttributedString {
        left.append(right)
        return left
    }
}

