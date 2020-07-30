//
//  NewTrekCVExe.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-27.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension NewTrekVC {
    
    
    
    //BOTTOM CONTROLS
    func addBottomControls(){
        newTrekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        newTrekSV.isPagingEnabled = true
        newTrekSV.backgroundColor = .clear
        newTrekSV.isScrollEnabled = true
        
        
        
        newTrekSV.translatesAutoresizingMaskIntoConstraints = false
        newTrekSV.contentInset = .zero
        newTrekSV.showsVerticalScrollIndicator = false
        newTrekSV.showsHorizontalScrollIndicator = false
        newTrekSV.clipsToBounds = true
        
        //BOTTOM CONTROLS
        view.addSubview(newTrekSV)
        newTrekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTrekSV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newTrekSV.heightAnchor.constraint(equalToConstant: newTrekSV.frame.height).isActive = true
        newTrekSV.widthAnchor.constraint(equalToConstant: newTrekSV.frame.width).isActive = true
        
        view.addSubview(previousButton)
        previousButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
        previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        previousButton.isHidden = true
        previousButton.isUserInteractionEnabled = false
        
        view.addSubview(cancelButton)
        cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        
         
        view.addSubview(nextButton)
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        
        view.addSubview(finishButton)
        finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        finishButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
        finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        finishButton.isHidden = true
        finishButton.isUserInteractionEnabled = false
        
        
        view.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/4).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/4).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        
        
        
        
    }
    
    //MARK: finishTrek
    @objc func finishTrek(){
        checkInputData()
        self.presentInFullScreen(UINavigationController(rootViewController: EditTrekViewController()), animated:true)
    }
    
    
    //MARK: cancelTrek
    @objc func cancelTrek(){
        AllTreks.treksArray.remove(at: AllTreks.treksArray.count-1)
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: prevPage
    @objc func prevPage(){
        print("Going to page: \(currPage)")
        
        
        if (currPage == 1){
            showCancelButton(isFirstPage: true)
            currPage -= 1
            pageControl.currentPage = currPage
            newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
        }else{
            showFinishButton(isLastPage: false)
            currPage -= 1
            pageControl.currentPage = currPage
            newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
        }
    
    }
    
    //MARK: nextPage
    @objc func nextPage(){
        print("Curr Page: \(currPage)")
        
        if (currPage == 0){
            showCancelButton(isFirstPage: false)
        }
        
        if(currPage+1 == 4){
            showFinishButton(isLastPage: true)
            currPage += 1
            pageControl.currentPage = currPage
            newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
        }else{
            currPage += 1
            pageControl.currentPage = currPage
            newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
        }
    }
    
    //MARK: imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[.editedImage] as? UIImage else {
            print("Shit")
            return
        }
        SingletonStruct.tempImg = image
        AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = UUID().uuidString
        AllTreks.treksArray[AllTreks.treksArray.count-1].imgData = image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        
        imgView.image = UIImage(data: Data.init(base64Encoded: AllTreks.treksArray[AllTreks.treksArray.count-1].imgData , options: .init(rawValue: 0))!)
        
        showClearImgBtn()
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: getImage
    @objc func getImage(tapGestureRecognizer: UITapGestureRecognizer){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }
    
    //MARK: showClearImgBtn
    private func showClearImgBtn(){
        clearImageButton.isUserInteractionEnabled = true
        clearImageButton.isHidden = false
    }
    
    //MARK: clearImage
    @objc func clearImage(){
        clearImageButton.isUserInteractionEnabled = false
                
        SingletonStruct.tempImg = UIImage(named: "img")!

        //        AllTreks.treksArray[AllTreks.treksArray.count-1].image = UIImage(named: "img")!
        AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = "img"
        imgView.image = SingletonStruct.tempImg
    }
    
    
    //MARK: textField Character Range
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 30
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTrekName.resignFirstResponder()
        inputTrekDestination.resignFirstResponder()
        
        if (inputItem.isFirstResponder){
            if ((inputItem.text?.trimmingCharacters(in: .whitespaces).isEmpty == true)){
                print("Invalid item entered")
            }else{
                print("Adding item: \(inputItem.text!)")
                
                AllTreks.treksArray[AllTreks.treksArray.count-1].items.append(inputItem.text!)
                AllTreks.treksArray[AllTreks.treksArray.count-1].crosses.append(false)
                inputItem.text = ""
                itemsTableView.reloadData()
                inputItem.resignFirstResponder()
            }
        }
        return true
    }

    

    //MARK: Tag Picker Stuff
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 3
       }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SingletonStruct.tags.count
       }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SingletonStruct.tags[row]
       }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            tagOne = SingletonStruct.tags[row]
        case 1:
            tagTwo = SingletonStruct.tags[row]
        case 2:
            tagThree = SingletonStruct.tags[row]
        default:
            print("nil")
        }
        
        tagsField.text = tagOne + " " +  tagTwo + " " + tagThree
        
        if (tagsField.text?.trimmingCharacters(in: .whitespaces).isEmpty == true){
            tagsField.text = ""
            tagOne = ""
            tagTwo = ""
            tagThree = ""
        }
    }
    
    //MARK: checkInputData
    private func checkInputData(){
        
        //TREK NAME
        if ((inputTrekName.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            SingletonStruct.untitledTrekCounter += 1
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = "Untitled Trek TODO VAR#"
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = inputTrekName.text!
        }
        
        //TREK DESTINATION
//        if ((inputTrekDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
//            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = ""
//        }else{
//            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = inputTrekDestination.text!
//        }
        AllTreks.treksArray[AllTreks.treksArray.count-1].destination = inputTrekDestination.titleLabel!.text!
        
        //TREK TAGS
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagOne)
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagTwo)
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagThree)
        
        //TREK DATES
        ///NO NEED TO CHECK DEPARTURE/RETURN FOR THIS STAGE - WILL BE CHECKED IN THE NEXT STAGE
        AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate = inputDeparture.text!
        AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate = inputReturn.text!
        
        
        
    }
}


//SCROLL VIEW EXTENSION
extension UIScrollView {

    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }

}


