//
//  InfoPickerDelegate.swift
//  StackApp
//
//  Created by John on 12/5/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class InfoPickerDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var infoPickerData: [String] = [String]()
    var ownerViewController: InfoViewProtocol!
    
    // numberOfComponents()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // numberOfRowsInComponent
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return infoPickerData.count
    }
    
    // titleForRow
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return infoPickerData[row]
    }
    
    // didSelectRow
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ownerViewController.constructLabelSentence()
    }
    
}
