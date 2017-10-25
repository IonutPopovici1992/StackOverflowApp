//
//  ProgressViewController.swift
//  StackApp
//
//  Created by John on 10/16/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sliderMaximumValue = sender.maximumValue
        progressView.progress = sender.value / sliderMaximumValue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configScrollView()
    }
    
    fileprivate func configScrollView() {
        self.scrollView.layer.borderColor = UIColor.black.cgColor
        self.scrollView.layer.borderWidth = 1
        self.scrollView.layer.cornerRadius = 5
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
