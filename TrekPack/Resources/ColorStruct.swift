//
//  ColorStruct.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

//Todo: Clean up names of the properties
struct ColorStruct{
    static let backgroundColor:UIColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    static let backgroundColor2:UIColor = UIColor(red: 253/255, green: 249/255, blue: 255/255, alpha: 0.75)
    static let titleColor:UIColor = UIColor(red: 7/255, green: 7/255, blue: 7/255, alpha: 1)
    static let subColor:UIColor = UIColor(red:111/255, green: 174/255, blue: 5/255, alpha: 1)
    static let greenColor:UIColor = UIColor(red:111/255, green: 174/255, blue: 5/255, alpha: 0.75)
    static let subColor2:UIColor = UIColor(red:111/255, green: 190/255, blue: 5/255, alpha: 1)
    
    static let pinkColor:UIColor = UIColor(red: 251/255, green: 199/255, blue: 212/255, alpha: 1)
    static let purpColor:UIColor = UIColor(red: 151/255, green: 150/255, blue: 240/255, alpha: 1)
    
    static let pinkColor2:UIColor = UIColor(red: 251/255, green: 199/255, blue: 212/255, alpha: 0.75)
    static let purpColor2:UIColor = UIColor(red: 151/255, green: 150/255, blue: 240/255, alpha: 0.75)
    
    static let testTransparent:UIColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.5)
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

