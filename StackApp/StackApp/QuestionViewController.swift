//
//  QuestionViewController.swift
//  StackApp
//
//  Created by John on 8/22/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, StackManagerDelegate {

    let stackManager = StackManagerDLG()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTable()
        configStackManager()
        configCollectionView()
    }

    @IBAction func switchQuestionsOnOff(_ sender: UISwitch) {
        if (sender.isOn == true) {
            table.isHidden = false
        } else {
            table.isHidden = true
        }
    }
    
    fileprivate func configTable() {
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    fileprivate func configStackManager() {
        self.stackManager.delegate = self
        self.stackManager.loadQuestions()
    }
    
    fileprivate func configCollectionView() {
        
        let interItemSize:CGFloat = 20.0
        let cellMargin:CGFloat = 20.0

        let widthSize = UIScreen.main.bounds.width/2.0 - (interItemSize/2.0) - cellMargin
        let heightSize:CGFloat = 100.0
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.sectionInset = UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin)
        layout.minimumInteritemSpacing = interItemSize
        layout.minimumLineSpacing = interItemSize
        
        collectionView.collectionViewLayout = layout
    }
    
    func dataTaskHasCompleted() {
        table.reloadData()
        collectionView.reloadData()
    }
    
}

extension QuestionViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stackManager.arrayOfQuestions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionsTableViewCell
        
        let question = self.stackManager.arrayOfQuestions[indexPath.row]
        cell.questionLabel.text = question.title
        
        if let unixTime = question.last_activity_date {
            cell.dateLabel.text = unixTime.unixFormattedTime()
        }
        
        return cell
    }
}

extension QuestionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stackManager.arrayOfQuestions.count
    }
    
    // Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuestionsCollectionViewCell
        
        let question = self.stackManager.arrayOfQuestions[indexPath.row]
        cell.questionLabel.text = question.title
        
        if let unixTime = question.last_activity_date {
            cell.dateLabel.text = unixTime.unixFormattedTime()
        }
        else {
            
            
        }
        
        print("question = \(question)")
        print("dateLabel text = \(cell.dateLabel.text ?? "")")
        
        return cell
    }
    
}
