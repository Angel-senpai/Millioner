//
//  SelectedDifficultyPopUp.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 04.08.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import UIKit

class SelectDifficultyPopUp: UIView {
    
    var foundation: UIView!
    var difArr = [DifficulView]()
    var button: UIButton!
    var textView: UITextView!
    var descriptionLabel: UILabel!
    var closeClouser:(()->())?
    init(difficultChange: Difficult) {
        super.init(frame: CGRect())
        self.frame = UIScreen.main.bounds
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7006100172)
        createFoundation(difficultChange)
        createDescriptionLabel()
        createButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createFoundation(_ difficult: Difficult){
        foundation = UIView()
        let size = CGSize(width: self.frame.width * 0.35,
                          height: self.frame.width * 0.35)
        let space = self.frame.width * 0.03
        difArr.append(contentsOf: [DifficulView(size: size,
                                                label: "Обычная",
                                                picture: #imageLiteral(resourceName: "Image-2"),
                                                state: false,
                                                description: "Игра с обычными правилами (вопросы от простых к сложным)",
                                                difficult: .normal),
                                   DifficulView(size: size,
                                   label: "Продвинутая",
                                   picture: #imageLiteral(resourceName: "Image"),
                                   state: false,
                                   description: "Рекомендуется для продвинутых пользователей\n(вопросы в перемешку)",
                                   difficult: .hard)])
        
        var maxX: CGFloat = 0.0
        let originY: CGFloat = 0.0
        for view in difArr{
            view.frame.origin.x = maxX
            view.frame.origin.y = originY
            foundation.frame.size.width = foundation.frame.width < view.frame.maxX ? view.frame.maxX : foundation.frame.width
            foundation.frame.size.height = foundation.frame.height < view.frame.maxY ? view.frame.maxY : foundation.frame.height
            maxX += view.frame.maxX + space
            view.button.addAction(for: .touchUpInside){[unowned self, weak view]  in
                guard let view = view else {return}
                self.difArr.forEach{
                    if $0.selected == true{
                        $0.selectedView()
                    }
                }
                view.selectedView()
                self.descriptionLabel.text = view.descr
            }
            if view.difficult == difficult {view.selectedView()}
            foundation.addSubview(view)
        }
        
        foundation.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.addSubview(foundation)
    }
    
    private func createDescriptionLabel(){
        descriptionLabel = UILabel(frame: CGRect(origin: CGPoint(),
                                                 size: CGSize(width: self.frame.width * 0.9, height: self.frame.height * 0.25)))
        descriptionLabel.font = .boldSystemFont(ofSize: self.frame.width * 0.055)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 4
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.center = CGPoint(x: self.frame.width / 2, y: foundation.frame.maxY + self.frame.width * 0.3)
        self.addSubview(descriptionLabel)
        for view in difArr{
            if view.selected{
                self.descriptionLabel.text = view.descr
            }
        }
    }
    
    private func createButton(){
        let buttonFrame = CGRect(x: 0, y: 0,
         width: self.frame.width * 0.8, height: self.frame.width * 0.15)
         button = UIButton(frame: buttonFrame)
         button.setTitleColor(.black, for: .normal)
         button.setTitle("Применить", for: .normal)
         button.titleLabel?.textAlignment = .center
         button.backgroundColor = .white
         button.layer.cornerRadius = button.frame.height / 3
         button.titleLabel?.font = .boldSystemFont(ofSize: self.frame.width * 0.045)
         button.center.x = self.frame.width / 2
         button.center.y = self.frame.height * 0.9
         self.addSubview(button)
        button.addAction {
            [unowned self] in
            self.difArr.forEach{
                if $0.selected{
                    DataBase.difficultGame = $0.difficult.rawValue
                }
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {self.alpha = 0}){ _ in
                self.removeFromSuperview()
                self.closeClouser?()
            }
        }
    }
    
}
