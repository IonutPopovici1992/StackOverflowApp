//
//  ProgressViewController.swift
//  StackApp
//
//  Created by John on 10/16/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var progressViewCompletion: UIProgressView!
    
    @IBAction func progressFromSlider(_ sender: UISlider) {
        let progressViewMaxValue = 100
        progressViewCompletion.progress = Float(Int(sender.value) / progressViewMaxValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
