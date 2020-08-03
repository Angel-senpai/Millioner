//
//  GameViewController.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 30.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var labelAnswer: UILabel!
    var delegate = GameSessionDelegate()
    var answerButton: UIButton!
    var gameSession: GameSession!
    var gameQuestionViews = [QuestionView]()
    var questCounter = 0{
        didSet(newValue){
            if newValue >= gameSession.questions.count - 1{
                delegate.rightAnswers = questCounter
                delegate.prize = questCounter
                endGame()
            }else{
                changeAswerLabel(text: gameSession.questions[questCounter].answer)
                for (i,j) in gameSession.questions[questCounter].answerOptions.enumerated(){
                    gameQuestionViews[i].label.text = j.key
                    gameQuestionViews[i].answerTrue = j.value
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameSession = Game.instance.gameSession
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.6941176471, green: 0.9294117647, blue: 0.9647058824, alpha: 1).cgColor,#colorLiteral(red: 0.6784313725, green: 0.7176470588, blue: 0.9568627451, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
        createAnswerLabel()
        createButton()
        guard let quest = gameSession.questions.first else{
            changeAswerLabel(text: "Для вас вопросов нет 🤪")
            answerButton.setTitle("Выход", for: .normal)
            return
        }
        createQuestionViews(quest: quest)
    }
    
    private func createAnswerLabel(){
        labelAnswer = UILabel()
        labelAnswer.textColor = .white
        labelAnswer.textAlignment = .center
        labelAnswer.font = .boldSystemFont(ofSize: self.view.frame.width * 0.06)
        labelAnswer.frame.size.height = self.view.frame.width * 0.3
        labelAnswer.frame.size.width = self.view.frame.width * 0.8
        labelAnswer.lineBreakMode = .byWordWrapping
        labelAnswer.numberOfLines = 3
        self.view.addSubview(labelAnswer)
    }
    private func changeAswerLabel(text:String){
        labelAnswer.text = text
        labelAnswer.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height * 0.2)
    }
    
    private func createQuestionViews(quest: Question){
        let foundation = UIView()
        let size = CGSize(width: self.view.frame.width * 0.35,
                          height: self.view.frame.width * 0.35)
        let space = self.view.frame.width * 0.09
        
        
        changeAswerLabel(text: quest.answer)
        for (key,value) in quest.answerOptions{
            gameQuestionViews.append(QuestionView(frame: CGRect(origin: CGPoint(), size: size), answer: key, value))
        }
        var maxX: CGFloat = 0.0
        var originY: CGFloat = 0.0
        for (number, view) in gameQuestionViews.enumerated(){
            view.frame.origin.x = maxX
            view.frame.origin.y = originY
            foundation.frame.size.width = foundation.frame.width < view.frame.maxX ? view.frame.maxX : foundation.frame.width
            foundation.frame.size.height = foundation.frame.height < view.frame.maxY ? view.frame.maxY : foundation.frame.height
            
            if number % 2 == 0{
                maxX += view.frame.maxX + space
            }else{
                maxX = 0
                originY += view.frame.maxY + space
            }
            
            foundation.addSubview(view)
        }
        foundation.center.x = self.view.frame.width / 2
        foundation.frame.origin.y = labelAnswer.frame.maxY + self.view.frame.width * 0.09
        self.view.addSubview(foundation)
    }
    
    private func createButton(){
        let buttonFrame = CGRect(x: 0, y: 0,
        width: self.view.frame.width * 0.8, height: self.view.frame.width * 0.15)
        answerButton = UIButton(frame: buttonFrame)
        answerButton.setTitleColor(.black, for: .normal)
        answerButton.setTitle("Ответить", for: .normal)
        answerButton.titleLabel?.textAlignment = .center
        answerButton.backgroundColor = .white
        answerButton.layer.cornerRadius = answerButton.frame.height / 3
        answerButton.titleLabel?.font = .boldSystemFont(ofSize: self.view.frame.width * 0.045)
        answerButton.center.x = self.view.frame.width / 2
        answerButton.center.y = self.view.frame.height * 0.9
        self.view.addSubview(answerButton)
        
        answerButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        
    }
    
    private func endGame(){
        Game.instance.gameSession = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkAnswers()-> Bool{
        let selectedQuestions = gameQuestionViews.filter{$0.selected}
        var answerIsRight = selectedQuestions.first?.answerTrue ?? false
        for i in selectedQuestions{
            if i.answerTrue{
                answerIsRight = answerIsRight && i.answerTrue
            }
        }
        return answerIsRight
    }
    
    
    @objc private func nextQuestion(){
        if checkAnswers(){
            delegate.rightAnswers += 1
        }
        print(delegate.rightAnswers)
        questCounter += 1
    }

}
