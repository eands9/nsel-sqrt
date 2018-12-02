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
    
    let allQuestions = QuestionList()
    var questionNumber: Int = 0
    var randomPick: Int = 0
    var correctAnswers: Int = 0
    var numberAttempts: Int = 0
    var numberFailed: Int = 0
    
    let congratulateArray = ["Great Job", "Excellent", "Way to go", "Alright", "Right on", "Correct", "Well done", "Awesome","Give me a high five"]
    let retryArray = ["Try again","Oooops"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        questionNumber = 0
        
        let firstQuestion = allQuestions.list[0].question
        questionLbl.text = firstQuestion
    }

    @IBOutlet weak var checkBtn: UILabel!
    
    @IBAction func chkBtn(_ sender: Any) {
        
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        
        if numberFailed == 1{
            
            readMe(myText: "The correct answer is")
            answerTxt.textColor = (UIColor.red)
            answerTxt.text = correctAnswer
            chkBtn .isEnabled = false
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                //next problem
                self.nextQuestion()
                self.numberFailed = 0
             }
            
        }
        else if answerTxt.text == correctAnswer{
            //congratulate
            randomPositiveFeedback()
            
            //next Question
            nextQuestion()
            
        }
        else {
            numberFailed += 1
            readMe(myText: "Try again")
            answerTxt.text = ""
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
        }
        else {
            print("why am I here")
        }
    }
}

