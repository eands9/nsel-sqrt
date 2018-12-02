//
//  Question.swift
//  NS-Elem-1
//
//  Created by Eric Hernandez on 12/2/18.
//  Copyright © 2018 Eric Hernandez. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let answer: String
    let answer2: String
    
    init(questionText: String, answerText: String, answerText2: String){
        question = questionText
        answer = answerText
        answer2 = answerText2
    }
}
