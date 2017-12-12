//
//  InfoViewController.swift
//  StackApp
//
//  Created by John on 11/20/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, InfoViewProtocol {
    
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var heightMetersPicker: UIPickerView!
    @IBOutlet weak var heightCentimetersPicker: UIPickerView!
    @IBOutlet weak var weightPicker: UIPickerView!
    
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var infoLabel: UILabel!
    
    // Delegates
    let genderDelegate = InfoPickerDelegate()
    let ageDelegate = InfoPickerDelegate()
    let heightMetersDelegate = InfoPickerDelegate()
    let heightCentimetersDelegate = InfoPickerDelegate()
    let weightDelegate = InfoPickerDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ageArray: [String] = [String]()
        var heightMetersArray: [String] = [String]()
        var heightCentimetersArray: [String] = [String]()
        var weightArray: [String] = [String]()
        
        for age in 0...150 {
            ageArray.append(String(age))
        }
        
        for meters in 0...3 {
            heightMetersArray.append(String(meters))
        }
        
        for centimeters in 0...99 {
            heightCentimetersArray.append(String(centimeters))
        }
        
        for weight in 0...250 {
            weightArray.append(String(weight))
        }
        
        // genderDelegate
        genderDelegate.infoPickerData = ["Male", "Female", "Other"]
        genderDelegate.ownerViewController = self
        // ageDelegate
        ageDelegate.infoPickerData = ageArray
        ageDelegate.ownerViewController = self
        // heightMetersDelegate
        heightMetersDelegate.infoPickerData = heightMetersArray
        heightMetersDelegate.ownerViewController = self
        // heightCentimetersDelegate
        heightCentimetersDelegate.infoPickerData = heightCentimetersArray
        heightCentimetersDelegate.ownerViewController = self
        // weightDelegate
        weightDelegate.infoPickerData = weightArray
        weightDelegate.ownerViewController = self
        
        genderPicker.delegate = genderDelegate
        genderPicker.dataSource = genderDelegate
        
        agePicker.delegate = ageDelegate
        agePicker.dataSource = ageDelegate
        
        heightMetersPicker.delegate = heightMetersDelegate
        heightMetersPicker.dataSource = heightMetersDelegate
        
        heightCentimetersPicker.delegate = heightCentimetersDelegate
        heightCentimetersPicker.dataSource = heightCentimetersDelegate
        
        weightPicker.delegate = weightDelegate
        weightPicker.dataSource = weightDelegate
        
        constructLabelSentence()
    }
    
    
    func constructLabelSentence() {

        let genderSelectedIndex = genderPicker.selectedRow(inComponent: 0)
        let genderValue = genderDelegate.infoPickerData[genderSelectedIndex]
        
        let ageSelectedIndex = agePicker.selectedRow(inComponent: 0)
        let ageValue = ageDelegate.infoPickerData[ageSelectedIndex]
        
        let metersSelectedIndex = heightMetersPicker.selectedRow(inComponent: 0)
        let metersValue = heightMetersDelegate.infoPickerData[metersSelectedIndex]
        
        let centimetersSelectedIndex = heightCentimetersPicker.selectedRow(inComponent: 0)
        let centimetersValue = heightCentimetersDelegate.infoPickerData[centimetersSelectedIndex]
        
        let weightSelectedIndex = weightPicker.selectedRow(inComponent: 0)
        let weightValue = weightDelegate.infoPickerData[weightSelectedIndex]
        
        let sentence = "The person is a \(genderValue)"
            + " and is \(ageValue) years old,"
            + " height \(metersValue) m & \(centimetersValue) cm,"
            + " weight \(weightValue) kg."
        
        infoLabel.text = String(sentence)
        
    }
    
}
