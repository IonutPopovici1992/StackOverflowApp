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
        // Do any additional setup after loading the view.
        configButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func configButtons() {
        self.button.layer.cornerRadius = 5;
        self.button.layer.borderWidth = 1;
        self.button.layer.borderColor = UIColor.black.cgColor;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
