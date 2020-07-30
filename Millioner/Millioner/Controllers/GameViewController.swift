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
    var delegate: NSObject!
    var answerButton: UIButton!
    var gameSession: GameSession!
    var gameQuestionViews = [QuestionView]()
    var questCounter = 0{
        didSet(newValue){
            if newValue >= gameSession.questions.count - 1{
                endGame()
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
        
        var maxX:CGFloat = 0.0
        changeAswerLabel(text: quest.answer)
        for (key,value) in quest.answerOptions{
            gameQuestionViews.append(QuestionView(frame: CGRect(origin: CGPoint(), size: size), answer: key, value))
        }
        var originY:CGFloat = 0.0
        gameQuestionViews.forEach{[weak self] in
            guard let self = self else {return}
            $0.frame.origin.x = maxX
            $0.frame.origin.y = originY
            foundation.frame.size.width = $0.frame.maxX
            maxX = foundation.frame.size.width + space
            if maxX > self.view.frame.width * 0.85{
                maxX = foundation.frame.minX
                originY = $0.frame.maxY + space
            }
            foundation.frame.size.height = $0.frame.maxY
            foundation.addSubview($0)
            
        }
        foundation.center.x = self.view.frame.width / 2
        foundation.frame.origin.y = labelAnswer.frame.maxY + self.view.frame.width * 0.09
        self.view.addSubview(foundation)
    }
    
    private func createButton(){
        let buttonFrame = CGRect(x: 0, y: 0,
        width: self.view.frame.width * 0.8, height: self.view.frame.width * 0.1)
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
    
    
    @objc private func nextQuestion(){
        questCounter += 1
        
        
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