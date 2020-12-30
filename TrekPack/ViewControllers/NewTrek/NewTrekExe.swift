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
    
    //MARK: addBottomControls
    func addBottomControls(){
        
        //newTrekScrollView settings
        newTrekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        newTrekSV.isPagingEnabled = true
        newTrekSV.backgroundColor = .clear
        newTrekSV.isScrollEnabled = true
        newTrekSV.translatesAutoresizingMaskIntoConstraints = false
        newTrekSV.contentInset = .zero
        newTrekSV.showsVerticalScrollIndicator = false
        newTrekSV.showsHorizontalScrollIndicator = false
        newTrekSV.clipsToBounds = true
        
        //NSLayoutConstraint for newTrekSV
        view.addSubview(newTrekSV)
        newTrekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTrekSV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newTrekSV.heightAnchor.constraint(equalToConstant: newTrekSV.frame.height).isActive = true
        newTrekSV.widthAnchor.constraint(equalToConstant: newTrekSV.frame.width).isActive = true
        
        //NSLayoutConstraint for previousButton
        view.addSubview(previousButton)
        previousButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
        previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        previousButton.isHidden = true
        previousButton.isUserInteractionEnabled = false
        
        //NSLayoutConstraint for cancelButton
        view.addSubview(cancelButton)
        cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        
        //NSLayoutConstraint for nextButton
        view.addSubview(nextButton)
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        
        //NSLayoutConstraint for finishButton
        view.addSubview(finishButton)
        finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        finishButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
        finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
        finishButton.isHidden = true
        finishButton.isUserInteractionEnabled = false
        
        //NSLayoutConstraint for pageControl
        view.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/4).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/4).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
    }
    
    //MARK: finishTrek
    @objc func finishTrek(){
        SingletonStruct.tempTrek.name = inputTrekName.text ?? ""
        SingletonStruct.tempTrek.departureDate = inputDeparture.text ?? ""
        SingletonStruct.tempTrek.returnDate = inputReturn.text ?? ""
        SingletonStruct.tempTrek.tags[0] = tagOne
        SingletonStruct.tempTrek.tags[1] = tagTwo
        SingletonStruct.tempTrek.tags[2] = tagThree
        self.presentInFullScreen(UINavigationController(rootViewController: FinalizeTrekViewController()), animated:true)
    }
    
    //MARK: cancelTrek
    @objc func cancelTrek(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: prevPage
    @objc func prevPage(){
        //Setting the UI according to what page the user is currently on
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
        
        //If the current page is 0 (aka the first page) then show the cancel button
        if (currPage == 0){
            showCancelButton(isFirstPage: false)
        }
        
        //If the current page is the last one then show the finish button, otherwise show the regular next and prev buttons
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
    
    //MARK: imagePickerControllerDidCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        spinner.stopAnimating()
        imgView.isUserInteractionEnabled = true
        newTrekSV.isUserInteractionEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Getting the image
        guard let image = info[.editedImage] as? UIImage else {
            placeHolderImage.isHidden = false
            spinner.stopAnimating()
            newTrekSV.isUserInteractionEnabled = true
            imgView.isUserInteractionEnabled = true
            return
        }
        
        //Setting the temp img
        SingletonStruct.tempImg = image
        
        //Setting the name and the data of the image
        SingletonStruct.tempTrek.imageName = UUID().uuidString
        SingletonStruct.tempTrek.imgData = image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        
        //Setting the imgView to the selected image
        imgView.image = UIImage(data: Data.init(base64Encoded: SingletonStruct.tempTrek.imgData , options: .init(rawValue: 0))!)
        placeHolderImage.isHidden = true
        
        //Setting UI accordingly
        showClearImgBtn()
        spinner.stopAnimating()
        imgView.isUserInteractionEnabled = true
        newTrekSV.isUserInteractionEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: getImage
    @objc func getImage(tapGestureRecognizer: UITapGestureRecognizer){
        spinner.startAnimating()
        imgView.isUserInteractionEnabled = false
        newTrekSV.isUserInteractionEnabled = true
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
        clearImageButton.isHidden = true
        SingletonStruct.tempImg = UIImage(named: "img")!
        placeHolderImage.isHidden = false
        SingletonStruct.tempTrek.imageName = "img"
        imgView.image = UIImage()
    }
    
    //MARK: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 30
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Resigning first responder
        if (inputTrekName.isFirstResponder){
            inputTrekName.resignFirstResponder()
        }

        if (inputTrekDestination.isFirstResponder){
            inputTrekDestination.resignFirstResponder()
        }
        

        //Used to ensure that the user is entering a correct string when entering an item
        if (inputItem.isFirstResponder){
            if ((inputItem.text?.trimmingCharacters(in: .whitespaces).isEmpty != true)){
                SingletonStruct.tempTrek.items.append(inputItem.text!)
                SingletonStruct.tempTrek.crosses.append(false)
                inputItem.text = ""
                itemsTableView.reloadData()
                inputItem.resignFirstResponder()
            }
        }
    
        newTrekSV.isScrollEnabled = true
        return true
    }

    

    //MARK: numberOfComponents Picker Stuff
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 3
       }
    
    
    //MARK: viewForRow
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        //Setting the view for row in the tag picker
        var pickerLabel: UILabel? = (view as? UILabel)
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Arial", size: 28)
            pickerLabel?.textAlignment = .center
        }
        
        pickerLabel?.font = UIFont(name: "Arial", size: 28)
        pickerLabel?.text = SingletonStruct.tags[row]
        
        return pickerLabel!
    }
    
    
    //MARK: numberOfRowsInComponent
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SingletonStruct.tags.count
       }
    
    
    //MARK: titleForRow
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SingletonStruct.tags[row]
       }
    
    
    //MARK: didSelectRow
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Determing which row was selected and setting the correct tag accordingly
        switch component {
        case 0:
            tagOne = SingletonStruct.tags[row]
        case 1:
            tagTwo = SingletonStruct.tags[row]
        case 2:
            tagThree = SingletonStruct.tags[row]
        default:
            print("default")
        }
        
        tagsField.text = tagOne + " " +  tagTwo + " " + tagThree
        
        if (tagsField.text?.trimmingCharacters(in: .whitespaces).isEmpty == true){
            tagsField.text = ""
            tagOne = ""
            tagTwo = ""
            tagThree = ""
        }
    }
}

//Scroll View Extension implementing the scrollTo method
extension UIScrollView {
    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
}


