//
//  TextsViewController.swift
//  StackApp
//
//  Created by John on 10/6/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class TextsViewController: UIViewController {
    
    // @IBOutlet
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // @IBAction
    @IBAction func action(_ sender: UIButton) {
        output.text = "Hello, " + (input.text)! + "!"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configButtons()
    }

    fileprivate func configButtons() {
        self.button.layer.borderColor = UIColor.black.cgColor;
        self.button.layer.borderWidth = 1;
        self.button.layer.cornerRadius = 5;
    }
    
}
