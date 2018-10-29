//
//  ViewController.swift
//  CreateMaruBatsuApp
//
//  Created by 工藤 響 on 2018/10/28.
//  Copyright © 2018 工藤 響. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var QuestionText: UITextView!
    let userDefaults = UserDefaults.standard
    var QuestionNum : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ShowQuestion()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let printRes = userDefaults.object(forKey: "Questions") as? [[String: Any]]
        ShowQuestion()
        print("ここはviewControllerの\(printRes)")
    }
    
    func ShowQuestion(){
        let questionText = userDefaults.object(forKey: "Questions") as? [[String: Any]]
        guard var inputQue = questionText?[QuestionNum] else{
        QuestionText.text = "問題がありません、問題を作りましょう！！！"
            return
        }

        
        if inputQue != nil{
            QuestionText.text = inputQue["question"] as? String
        

        }
        
    }
    
    func CheckAnswer(Answer: Bool){
        let questionText = userDefaults.object(forKey: "Questions") as? [[String: Any]]

        guard let question = questionText?[QuestionNum] else {
            return
        }
        
        if let ans = question["answer"] as? Bool{
            
            if ans == Answer{
                showAlert("正解です")
            
            }else{
                showAlert("不正解です")
            }
            
            QuestionNum += 1
        }
        

        if (questionText?.count)! <= QuestionNum{
            QuestionNum = 0
            
        }
        
        ShowQuestion()
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func Notapped(_ sender: Any) {
        CheckAnswer(Answer: false)
    }
    
    @IBAction func Yestapped(_ sender: Any) {
        CheckAnswer(Answer: true)
    }
    @IBAction func GoCreate(_ sender: Any) {
        QuestionNum = 0
    }
}

