//
//  ViewController.swift
//  NS-Elem-1
//
//  Created by Eric Hernandez on 12/2/18.
//  Copyright © 2018 Eric Hernandez. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController {
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerTxt: UITextField!
    @IBOutlet weak var chkBtn: UIButton!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    let allQuestions = QuestionList()
    var questionNumber: Int = 0
    var randomPick: Int = 0
    var correctAnswers: Int = 0
    var numberAttempts: Int = 0
    var numberFailed: Int = 0
    
    var timer = Timer()
    var counter = 0.0
    var isRunning = false
    
    let congratulateArray = ["Great Job", "Excellent", "Way to go", "Alright", "Right on", "Correct", "Well done", "Awesome","Give me a high five"]
    let retryArray = ["Try again","Oooops"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        questionNumber = 0
        questionNumberLbl.text = "Question #\(questionNumber + 1)"
        let firstQuestion = allQuestions.list[0].question
        questionLbl.text = firstQuestion
        
        timerLbl.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }

    @IBOutlet weak var checkBtn: UILabel!
    
    @objc func updateTimer(){
        counter += 0.1
        timerLbl.text = String(format:"%.1f",counter)
    }
    
    @IBAction func chkBtn(_ sender: Any) {
        
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if answerTxt.text == correctAnswer{
            //congratulate
            randomPositiveFeedback()
            
            //next Question
            nextQuestion()
            correctAnswers += 1
            numberAttempts += 1
            updateProgress()
            numberFailed = 0
        }

        else
            if numberFailed == 1{
                
                readMe(myText: "The correct answer is")
                answerTxt.textColor = (UIColor.red)
                answerTxt.text = correctAnswer
                numberAttempts += 1
                updateProgress()
                chkBtn .isEnabled = false
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    //next problem
                    self.nextQuestion()
                    self.numberFailed = 0
                    
                }
                
            }
        else {
            numberFailed += 1
            readMe(myText: "Try again")
            answerTxt.text = ""
            numberAttempts += 1
            updateProgress()
        }
        
    }
    
    func readMe( myText: String) {
        let utterance = AVSpeechUtterance(string: myText )
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func randomPositiveFeedback(){
        randomPick = Int(arc4random_uniform(9))
        readMe(myText: congratulateArray[randomPick])
        
    }
    
    func nextQuestion(){
        chkBtn .isEnabled = true
        answerTxt.text = ""
        answerTxt.textColor = (UIColor.black)
        questionNumber += 1
        //if there are 14 questions, the number below should be 13 (always one less)
        if questionNumber <= 48 {
            
            questionLbl.text = allQuestions.list[questionNumber].question
            questionNumberLbl.text = "Question #\(questionNumber + 1)"
        }
        else {
            print("why am I here")
        }
    }
    
    func updateProgress(){
        progressLbl.text = "\(correctAnswers) / \(numberAttempts)"
    }
}

