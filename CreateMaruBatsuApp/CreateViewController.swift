//
//  CreateViewController.swift
//  CreateMaruBatsuApp
//
//  Created by 工藤 響 on 2018/10/28.
//  Copyright © 2018 工藤 響. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet var InputQuestion: UITextField!
    let userDefaults = UserDefaults.standard
    
    var AnswerResult:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func BackTop(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TFChoice(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            AnswerResult = false
            print("✗の\(AnswerResult)です。")
        }else if sender.selectedSegmentIndex == 1{
            AnswerResult = true
            print("マルの\(AnswerResult)です。")
        }
    }
    
    @IBAction func CreateQuestion(_ sender: Any) {
        if InputQuestion.text == "" {
            showAlert(message: "問題文を入力してください")
            return
        }
        var SaveSub:[String:Any] = [:]
        SaveSub["question"] = InputQuestion.text!
        SaveSub["answer"] = AnswerResult
        
        if var SaveQuestion = userDefaults.object(forKey: "Questions") as? [[String: Any]]{
        SaveQuestion.append(SaveSub)
        userDefaults.set(SaveQuestion,forKey: "Questions")
        InputQuestion.text = ""
        }else{
            let sendItem:[[String:Any]] = [SaveSub]
            userDefaults.set(sendItem,forKey: "Questions")
            InputQuestion.text = ""
        }
        print("ここはCreateViewConの\(userDefaults.data(forKey: "Questions"))")
    }
    
    @IBAction func DeleteQuestions(_ sender: Any) {
        userDefaults.removeObject(forKey: "Questions")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
