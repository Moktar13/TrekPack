//
//  NewTrekCVExe.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-27.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

extension NewTrekVC {
    
    //IMAGE PICKER STUFF
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            print("Shit")
            return
        }
        AllTreks.treksArray[AllTreks.treksArray.count-1].image = image
        AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = UUID().uuidString
        imgView.image = image
        
        showClearImgBtn()
        
        dismiss(animated: true, completion: nil)
    }
    @objc func getImage(tapGestureRecognizer: UITapGestureRecognizer){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }
    
    
    private func showClearImgBtn(){
        clearImageButton.isUserInteractionEnabled = true
        clearImageButton.isHidden = false
    }
    
    
    ///TODO: Some fancy animation with button hiding, etc
    @objc func clearImage(){
        clearImageButton.isUserInteractionEnabled = false
        AllTreks.treksArray[AllTreks.treksArray.count-1].image = UIImage(named: "img")!
        AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = "img"
        imgView.image = AllTreks.treksArray[AllTreks.treksArray.count-1].image
        clearImageButton.isHidden = true
    }
    
    
    //TEXT FIELD STUFF
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 35
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTrekName.resignFirstResponder()
        inputTrekDestination.resignFirstResponder()
        
        if (inputItem.isFirstResponder){
            if ((inputItem.text?.trimmingCharacters(in: .whitespaces).isEmpty == true)){
                print("Invalid item entered")
            }else{
                print("Adding item: \(inputItem.text!)")
                
                AllTreks.treksArray[AllTreks.treksArray.count-1].items.append(inputItem.text!)
                inputItem.text = ""
                itemsTableView.reloadData()
                inputItem.resignFirstResponder()
            }
        }
        return true
    }
    
    
    
    //NAVIGATION STUFF
    @objc func prevPage(){
        print("Going to page: \(currPage)")
        
        if (currPage == 0){
            AllTreks.treksArray.remove(at: AllTreks.treksArray.count-1)
            dismiss(animated: true, completion: nil)
        }else{
            currPage -= 1
            pageControl.currentPage = currPage
            newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
            
        }
    }
    @objc func nextPage(){
        
        
        if(currPage+1 == 5){
            checkInputData()
            
            
            
            let firstVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTVC")
            let navController = UINavigationController(rootViewController: firstVC)
            self.presentInFullScreen(navController, animated:true, completion: nil)
        }else{
            currPage += 1
            pageControl.currentPage = currPage
            newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
        }
    }
    
    
    //TAG PICKER STUFF
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 3
       }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tags.count
       }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tags[row]
       }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            tagOne = tags[row]
        case 1:
            tagTwo = tags[row]
        case 2:
            tagThree = tags[row]
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
    
    
    
    private func checkInputData(){
        
        //TREK NAME
        if ((inputTrekName.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            SingletonStruct.untitledTrekCounter += 1
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = "Untitled Trek TODO VAR#"
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = inputTrekName.text!
        }
        
        //TREK DESTINATION
        if ((inputTrekDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = ""
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = inputTrekDestination.text!
        }
        
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


