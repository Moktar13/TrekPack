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
    
    


    //COLORS~~~~
    static let titleColor:UIColor = UIColor(red: 7/255, green: 7/255, blue: 7/255, alpha: 1)
    static let testBlack:UIColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    static let testGold:UIColor = UIColor(red: 255/255, green: 189/255, blue: 27/255, alpha: 1.0)
    static let testWhite:UIColor = UIColor(red: 250/255, green: 255/255, blue: 250/255, alpha: 1.0)
    static let testGray:UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    static let backgroundColor:UIColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
    static let newBlack:UIColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    static let newWhite:UIColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
    static let testBlue:UIColor = UIColor(red: 5/255, green: 95/255, blue: 233/255, alpha: 1.0)
    static let testGrey:UIColor = UIColor(red: 248/255, green: 241/255, blue: 233/255, alpha: 1.0)
       
    
    //FONTS~~~~
    static let subHeaderFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 16)!
    static let subHeaderFontv2:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 18)!
    static let inputFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    static let headerFont:UIFont = UIFont.init(name: "AvenirNext-DemiBold", size: 26)!
    static let secondaryHeaderFont:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 19)!
    static let inputItemFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    static let navTitle:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 23)!
    static let navBtnTitle:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 19)!
    static let clearImg:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 13)!
    static let tagInputFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 27)!
    static let pageOneHeader:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 31)!
    static let pageOneSubHeader:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 24)!
    static let inputLabel:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 24)!
    static let buttonFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    static let buttonFontTwo:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 18)!
    static let tagFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 29)!
    static let infoTitleFont:UIFont = UIFont.init(name: "AvenirNext-DemiBold", size: 28)!
    static let infoDestFont:UIFont = UIFont.init(name: "AvenirNext-DemiBold", size: 18)!
    static let trekDetailsFont:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 16)!
    static let bigFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 50)!
    static let trekTipsFont:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 20)!
    static let tipTitleFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 40)!
    static let tipSubtitleFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 25)!
    
    
    static let mapTitleFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 18)!
    static let mapSubTitleFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 14)!

    
    //OTHER SHIT~~~~
    static let stackViewSeparator:CGFloat = 5.0
    static var doneMakingTrek:Bool = false
    static var untitledTrekCounter:Int = 0
    static var hasDeparture:Bool = false
    static var deleteCellHeight:CGFloat = 0.0
    static var deleteWordCount:Int = 0
    static var isViewingPage:Bool = false
    static var testBase64:String = ""
    
    static var tempImg:UIImage = UIImage(named: "sm")!
    
    
    //TAGS~~~~~
    static let tags = ["", "🚌", "🚈", "✈️", "🛶", "⛵️", "🛳", "🏰", "🏝","🌲", "🌴","🏔", "⛺️", "🗽", "🏛", "🏟", "🏙", "🌆", "🌉", "🏞", "🎣", "🤿", "🏂", "🪂", "🏄🏻‍♂️", "🧗‍♀️", "🚴", "🌞", "🌻", "🌚", "🌙", "🌈", "🌊", "🌍", "🗺", "❄️", "⛄️" ]
    
    
   

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


extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: animated, completion: completion)
  }
}

extension UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}


extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}


//Code for adding a line underneath the textfield input (idk what it does!!)
enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        
        lineView.clipsToBounds = true
        lineView.layer.cornerRadius = CGFloat(width/64) + 1
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
        
        print("Ass \(lineView.frame.width)")
        
    }
}

//Use to dimiss the keyboard on tap
extension UIViewController {
    
    //Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}


