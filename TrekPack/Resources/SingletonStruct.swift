//
//  ColorStruct.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//
import UIKit
import Foundation
import CoreData

//Singleton Struct which holds several immutable values that are used throughout the app
struct SingletonStruct{

    //CoreData
    static var treksCoreData: [NSManagedObject] = []
    
    // Storing trek new format
    static var allTreks : [TrekStruct] = []
    static var treksByDate : [TrekStruct] = []
    static var trekCountDown : [Int] = []
    static var selectedTrek: Int = -1
    static var makingNewTrek: Bool = false
    
    
    
    
    //Colors
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
       
    //Fonts
    static let subHeaderFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 16)!
    static let subHeaderFontv2:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 18)!
    static let subHeaderFontv3:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 22)!
    static let subHeaderFontv4:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 18)!
    static let inputFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    static let headerFont:UIFont = UIFont.init(name: "AvenirNext-DemiBold", size: 26)!
    static let secondaryHeaderFont:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 19)!
    static let inputItemFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 20)!
    static let navTitle:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 23)!
    static let navBtnTitle:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 19)!
    static let clearImg:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 13)!
    static let tagInputFont:UIFont = UIFont.init(name: "AvenirNext-Regular", size: 27)!
    static let pageOneHeader:UIFont = UIFont.init(name: "AvenirNext-Medium", size: 31)!
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

    //User Defaults
    static let defaults = UserDefaults.standard
    static let defaultsKey = "saved"
    
    //Random variables/constants used throughout the project
    static let stackViewSeparator:CGFloat = 5.0
    static var doneMakingTrek:Bool = false
    static var isViewingPage:Bool = false
    static var testBase64:String = ""
    static var statusBarHeight = 0.0
    static var tempImg:UIImage = UIImage(named: "sm")!
    static var isEdit:Bool = false
    
    //Temp Trek used to store newly edited features of the selected trek
    static var tempTrek:TrekStruct = TrekStruct(name: "", destination: "", departureDate: "", returnDate: "", items: [], crosses: [], tags: [], imageName: "", imgData: "", streetNumber: "", streetName: "", subCity: "", city: "", municipality: "", province: "", postal: "", country: "", countryISO: "", region: "", ocean: "", latitude: 0.0, longitude: 0.0, distance: 0.0, distanceUnit: "", timeZone: "")
    
    //Tags
    static let tags = ["", "🚗", "🚎", "🛵", "🚠", "🚅", "✈️", "🚁", "🛶", "🚤", "🛳", "🗺", "🗽", "🗼", "🏰", "🏯", "🏛","🏟", "🎡", "🏖", "🏝", "🌋", "🏔", "🏕", "🌲" , "🍁", "🌤", "⛄️", "🌊", "🏞", "🌄", "🌆", "🏙", "🌉", "🏂", "🏌️", "🏄", "🚣‍♂️", "🚴‍♂️", "🧗‍♀️"]
}

//MARK: Extensions

//Extension of NSAttributedString used holding functions that allow for merging of NSAttributedStrings
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




//UIViewController extension holding a function which will present a view controller in fullscreen modes
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

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

//Extension of UIView holding function which will add a line to the respective UIView
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



//Extension of dispatch queue to make doing work in the background thread easier
extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

