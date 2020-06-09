//
//  NewTrekExtension.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-02-01.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

extension EditTrekViewController{
    
    //UI SETUP
    func setupUI(){
    
        //TREK NAME
        view.addSubview(trekNameLabel)
        trekNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        trekNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        trekNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width/16).isActive = true
        
        view.addSubview(backdropLabelOne)
        backdropLabelOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
        backdropLabelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
        backdropLabelOne.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true
        backdropLabelOne.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(inputTrekName)
        inputTrekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputTrekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        inputTrekName.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true
        inputTrekName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //TREK DESTINATION
        view.addSubview(trekDestinationLabel)
        trekDestinationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        trekDestinationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        trekDestinationLabel.topAnchor.constraint(equalTo: inputTrekName.bottomAnchor, constant: view.frame.width/16).isActive = true
        
        view.addSubview(backdropLabelTwo)
        backdropLabelTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
        backdropLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
        backdropLabelTwo.topAnchor.constraint(equalTo: trekDestinationLabel.bottomAnchor).isActive = true
        backdropLabelTwo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        

        view.addSubview(inputTrekDestination)
        inputTrekDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputTrekDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        inputTrekDestination.topAnchor.constraint(equalTo: trekDestinationLabel.bottomAnchor).isActive = true
        inputTrekDestination.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        

        
        //DEPARTURE
        view.addSubview(departureLabel)
        departureLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
        departureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        departureLabel.topAnchor.constraint(equalTo: inputTrekDestination.bottomAnchor, constant: view.frame.width/16).isActive = true
        
        view.addSubview(backdropLabelThree)
        backdropLabelThree.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
        backdropLabelThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
        backdropLabelThree.topAnchor.constraint(equalTo: departureLabel.bottomAnchor).isActive = true
        backdropLabelThree.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(inputDeparture)
        inputDeparture.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
        inputDeparture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        inputDeparture.topAnchor.constraint(equalTo: departureLabel.bottomAnchor).isActive = true
        inputDeparture.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
 
        //RETURN
        view.addSubview(returnLabel)
        returnLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        returnLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
        returnLabel.topAnchor.constraint(equalTo: inputTrekDestination.bottomAnchor, constant: view.frame.width/16).isActive = true
        
        view.addSubview(backdropLabelFour)
        backdropLabelFour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        backdropLabelFour.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/22).isActive = true
        backdropLabelFour.topAnchor.constraint(equalTo: returnLabel.bottomAnchor).isActive = true
        backdropLabelFour.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(inputReturn)
        inputReturn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputReturn.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
        inputReturn.topAnchor.constraint(equalTo: returnLabel.bottomAnchor).isActive = true
        inputReturn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //TAGS
        view.addSubview(tagsLabel)
        tagsLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
        tagsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        tagsLabel.topAnchor.constraint(equalTo: inputDeparture.bottomAnchor, constant: view.frame.width/16).isActive = true
       
        view.addSubview(backdropLabelFive)
        backdropLabelFive.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
        backdropLabelFive.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
        backdropLabelFive.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor).isActive = true
        backdropLabelFive.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(tagsField)
        tagsField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
        tagsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        tagsField.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor).isActive = true
        tagsField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //ITEMS
        view.addSubview(itemsLabel)
        itemsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemsLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
        itemsLabel.topAnchor.constraint(equalTo: inputReturn.bottomAnchor, constant: view.frame.width/16).isActive = true
       
        view.addSubview(backdropLabelSix)
        backdropLabelSix.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        backdropLabelSix.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/22).isActive = true
        backdropLabelSix.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor).isActive = true
        backdropLabelSix.heightAnchor.constraint(equalToConstant: 40).isActive = true
       
        view.addSubview(itemsButton)
        itemsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemsButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
        itemsButton.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor).isActive = true
        itemsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
      
    
        //TREK IMAGE
        view.addSubview(imgVStack)
        imgVStack.addArrangedSubview(imageLabel)
        imgVStack.addArrangedSubview(imgView)
        imgVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        imgVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        imgVStack.topAnchor.constraint(equalTo: tagsField.bottomAnchor, constant: view.frame.width/16).isActive = true

        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - (view.frame.width/10 * 3.5)).isActive = true
        
        
        view.addSubview(clearImageButton)
        clearImageButton.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -view.frame.width/64).isActive = true
        clearImageButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        clearImageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        clearImageButton.trailingAnchor.constraint(equalTo: imgView.trailingAnchor).isActive = true
        
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].imageName == "img"){
            clearImageButton.isHidden = true
            clearImageButton.isUserInteractionEnabled = false
        }else{
            clearImageButton.isHidden = false
            clearImageButton.isUserInteractionEnabled = true
        }
        
        
    }
    
    //PICKER STUFF
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
           
       tagsField.text = tagOne + tagTwo + tagThree
   }
    
    
    //DONE PRESSED
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if (inputDeparture.isFirstResponder){
            inputDeparture.text = formatter.string(from: datePicker.date)
            print("Selecting departure")
        }
        
        if (inputReturn.isFirstResponder){
            inputReturn.text = formatter.string(from: datePicker.date)
            print("Selecting return")
        }
        self.view.endEditing(true)
    }
      
      
    //IMAGE PICKER STUFF
    ///TODO: Some fancy animation with button hiding, etc
    @objc func clearImage(){
        clearImageButton.isUserInteractionEnabled = false
        
        AllTreks.treksArray[AllTreks.treksArray.count-1].image = UIImage(named: "img")!
        AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = "img"
        imgView.image = AllTreks.treksArray[AllTreks.treksArray.count-1].image
        
        
       
        clearImageButton.isHidden = true

    }
    @objc func getImage(tapGestureRecognizer: UITapGestureRecognizer){
        
        if (inputTrekName.isFirstResponder){
            inputTrekName.resignFirstResponder()
        }
        else if (inputTrekDestination.isFirstResponder){
            inputTrekDestination.resignFirstResponder()
        }
        else if (inputDeparture.isFirstResponder){
            inputDeparture.resignFirstResponder()
        }
        else if (inputReturn.isFirstResponder){
            inputReturn.resignFirstResponder()
        }
        else if (tagsField.isFirstResponder){
            tagsField.resignFirstResponder()
        }
        
        
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        
        picker.delegate = self
        present(picker,animated: true)
    }
    private func showClearImgBtn(){
        clearImageButton.isUserInteractionEnabled = true
        clearImageButton.isHidden = false
    }
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
    
   

}


class AutomaticHeightTableView: UITableView {

  override var contentSize: CGSize {
    didSet {
      self.invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    self.layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }

}
