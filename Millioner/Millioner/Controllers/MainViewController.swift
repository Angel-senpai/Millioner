//
//  ViewController.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 15.06.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import UIKit

enum Difficult: Int{
    case normal
    case hard
    
    var strategy: GameSessionStrategy.Type{
        switch self {
        case .hard:
            return RandomQuestionsStrategy.self
        case .normal:
            return StandartQuestionsStrategy.self
        }
    }
}

class MainViewController: UIViewController {
    
    var buttonStartGame: UIButton!
    var buttonResult: UIButton!
    var label: UILabel!
    var difEnum: Difficult{Difficult.init(rawValue: DataBase.difficultGame) ?? .normal}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let buttonFrame = CGRect(x: 0, y: 0,
        width: self.view.frame.width * 0.8, height: self.view.frame.width * 0.15)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = [#colorLiteral(red: 0.6941176471, green: 0.9294117647, blue: 0.9647058824, alpha: 1).cgColor,#colorLiteral(red: 0.6784313725, green: 0.7176470588, blue: 0.9568627451, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        createButtonStartGame(buttonFrame)
        createButtonResult(buttonFrame)
        createSettingsButton()
        
        label = UILabel()
        label.text = "Кто хочет стать миллионером"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: self.view.frame.width * 0.06)
        label.sizeToFit()
        label.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height * 0.2)
        self.view.addSubview(label)
    }
    
    
    private func createButtonStartGame(_ frame: CGRect){
        buttonStartGame = UIButton(frame: frame)
        buttonStartGame.setTitleColor(.black, for: .normal)
        buttonStartGame.setTitle("Начать", for: .normal)
        buttonStartGame.titleLabel?.textAlignment = .center
        buttonStartGame.backgroundColor = .white
        buttonStartGame.layer.cornerRadius = buttonStartGame.frame.height / 3
        buttonStartGame.titleLabel?.font = .boldSystemFont(ofSize: self.view.frame.width * 0.045)
        buttonStartGame.center.x = self.view.frame.width / 2
        buttonStartGame.center.y = self.view.frame.height / 2
        self.view.addSubview(buttonStartGame)
        
        buttonStartGame.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
    }
    
    private func createButtonResult(_ frame: CGRect){
        buttonResult = UIButton(frame: frame)
        buttonResult.backgroundColor = .white
        buttonResult.setTitleColor(.black, for: .normal)
        buttonResult.setTitle("Результаты", for: .normal)
        buttonResult.titleLabel?.textAlignment = .center
        buttonResult.titleLabel?.font = .boldSystemFont(ofSize: self.view.frame.width * 0.045)
        buttonResult.layer.cornerRadius = buttonResult.frame.height / 3
        buttonResult.center.x = self.view.frame.width / 2
        buttonResult.center.y = buttonStartGame.frame.maxY + buttonResult.frame.height + self.view.frame.width * 0.05
        self.view.addSubview(buttonResult)
        buttonResult.addTarget(self, action: #selector(getSessions), for: .touchUpInside)
    }
    
    private func createSettingsButton(){
        let frameSize = CGSize(width: self.view.frame.width * 0.1, height: self.view.frame.width * 0.1)
        let settingsView = UIView(frame: CGRect(origin: CGPoint(), size: frameSize))
        
        let image = UIImageView(frame: settingsView.bounds)
        image.image = #imageLiteral(resourceName: "Settings")
        settingsView.backgroundColor = .white
        settingsView.mask = image
        
        settingsView.frame.origin.x = self.view.frame.width - settingsView.frame.width - self.view.frame.width * 0.05
        settingsView.frame.origin.y = self.view.frame.height * 0.1
        
        let button = UIButton(frame: settingsView.bounds)
        settingsView.addSubview(button)
        button.addAction {
            [unowned self] in
            self.createPopUp()
        }
        
        self.view.addSubview(settingsView)
    }
    
    @objc func getSessions(){
        let resultController = ResultViewController()
        resultController.modalPresentationStyle = .fullScreen
        resultController.modalTransitionStyle = .crossDissolve
        self.present(resultController, animated: true, completion: nil)
    }
    
    private func createPopUp(_ closeClouser: (()->())? = nil){
        if DataBase.firstGame == 0{DataBase.firstGame += 1}
        let popUp = SelectDifficultyPopUp(difficultChange: self.difEnum)
        popUp.closeClouser = closeClouser
        popUp.alpha = 0
        self.view.addSubview(popUp)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {popUp.alpha = 1})
    }
    
    @objc private func getStarted(){
        if DataBase.firstGame == 0{
            createPopUp({ [unowned self] in
                let gameController = GameViewController()
                Game.instance.setGameSession(session: GameSession(strategy: self.difEnum.strategy))
                gameController.modalPresentationStyle = .fullScreen
                gameController.modalTransitionStyle = .coverVertical
                self.present(gameController, animated: true, completion: nil)
            })
            DataBase.firstGame += 1
        }else{
            let gameController = GameViewController()
            Game.instance.setGameSession(session: GameSession(strategy: self.difEnum.strategy))
            gameController.modalPresentationStyle = .fullScreen
            gameController.modalTransitionStyle = .crossDissolve
            self.present(gameController, animated: true, completion: nil)
        }
    }


}

extension MainViewController: UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
