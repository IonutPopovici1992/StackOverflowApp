//
//  QuestionViewController.swift
//  StackApp
//
//  Created by John on 8/22/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var questions = [Question]()
    var tappedQuestion: Question?
    var tableRefreshControl = UIRefreshControl()
    var collectionRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pageIndex: UInt = 0
    let pageSize: UInt = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTable()
        configCollectionView()
        requestNextQuestions(resetPrevious: false)
        
        setupRefreshControlForTable()
        setupRefreshControlForCollection()
    }
    
    /// configTable()
    fileprivate func configTable() {
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    /// configCollectionView()
    fileprivate func configCollectionView() {
        
        let interItemSize: CGFloat = 20.0
        let cellMargin: CGFloat = 20.0
        
        let widthSize = UIScreen.main.bounds.width/2.0 - (interItemSize/2.0) - cellMargin
        let heightSize: CGFloat = 100.0
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.sectionInset = UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin)
        layout.minimumInteritemSpacing = interItemSize
        layout.minimumLineSpacing = interItemSize
        
        collectionView.collectionViewLayout = layout
    }
    
    /// requestNextQuestions()
    fileprivate func requestNextQuestions(resetPrevious: Bool) {
        pageIndex += 1
        StackManagerClosures.loadQuestions(pageIndex: pageIndex,
                                           pageSize: pageSize) { (questionsOrNil, errorOrNil) in
                                            self.handleQuestionsResponse(questionsOrNil: questionsOrNil,
                                                                         errorOrNil: errorOrNil,
                                                                         reset: resetPrevious)
        }
    }
    
    /// handleQuestionsResponse()
    fileprivate func handleQuestionsResponse(questionsOrNil: [Question]?, errorOrNil: Error?, reset: Bool) {
        if let unwrappedQuestions = questionsOrNil {
            if reset == true {
                questions.removeAll()
            }
            
            self.questions.append(contentsOf: unwrappedQuestions)
            self.table.reloadData()
            self.collectionView.reloadData()
        } else {
            self.showAlert(error: errorOrNil)
        }
        
        self.tableRefreshControl.endRefreshing()
        self.collectionRefreshControl.endRefreshing()
    }
    
    /// showAlert()
    fileprivate func showAlert(error: Error?) {
        let title = "Oupsss!"
        let message = "There was an issue while trying to obtain the latest questions: \(error.debugDescription)"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// setupRefreshControlForTable()
    func setupRefreshControlForTable() {
        tableRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableRefreshControl.addTarget(self,
                                      action: #selector(refreshQuestions),
                                      for: UIControlEvents.valueChanged)
        table.addSubview(tableRefreshControl)
    }
    
    /// setupRefreshControlForCollection()
    func setupRefreshControlForCollection() {
        collectionRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        collectionRefreshControl.addTarget(self,
                                           action: #selector(refreshQuestions),
                                           for: UIControlEvents.valueChanged)
        collectionView.addSubview(collectionRefreshControl)
        
    }
    
    /// refreshQuestions()
    @objc fileprivate func refreshQuestions() {
        pageIndex = 0
        requestNextQuestions(resetPrevious: true)
    }
    
    /// prepare()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let answersViewController = segue.destination as? AnswersViewController {
            answersViewController.currentQuestion = self.tappedQuestion
        }
    }
    
    /// switchQuestionsOnOff()
    @IBAction func switchQuestionsOnOff(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.3) {
            self.table.alpha = sender.isOn ? 0.0 : 1.0
            self.collectionView.alpha = sender.isOn ? 1.0 : 0.0
        }
    }
    
    /// dataTaskHasCompleted()
    func dataTaskHasCompleted() {
        table.reloadData()
        collectionView.reloadData()
    }
    
}


extension QuestionViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    // Populate row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionsTableViewCell
        
        let question = questions[indexPath.row]
        cell.questionLabel.text = question.title
        cell.dateLabel.text = question.last_activity_date.unixFormattedTime(format: SADateFormat.shortDate)
        
        if (indexPath.row == questions.count - 1) {
            self.requestNextQuestions(resetPrevious: false)
        }
        
        return cell
    }
}


extension QuestionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    // Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuestionsCollectionViewCell
        
        let question = questions[indexPath.row]
        cell.questionLabel.text = question.title
        cell.dateLabel.text = question.last_activity_date.unixFormattedTime(format: SADateFormat.longDate)
        
        let row = Int(indexPath.row / 2)
        
        if row % 2 != 0 {
            cell.backgroundColor = UIColor.cyan
        } else {
            cell.backgroundColor = UIColor.yellow
        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5
        
        if (indexPath.row == questions.count - 1) {
            self.requestNextQuestions(resetPrevious: false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tappedQuestion = questions[indexPath.row]
        
        self.performSegue(withIdentifier: SASegueIdentifiers.segueFromQuestionsToAnswers, sender: self)
    }
    
}
